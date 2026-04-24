$ErrorActionPreference = "Stop"
Add-Type -AssemblyName PresentationFramework

$appRoot = Split-Path -Parent $PSCommandPath
$logDir = Join-Path $appRoot "logs"
$configTemplate = Join-Path $appRoot "config-examples\.env.example_CN"
$envFile = Join-Path $appRoot ".env"
$nodeExe = Join-Path $appRoot "runtime\node\node.exe"
$frontendServer = Join-Path $appRoot "web\server.js"
$sitePackages = Join-Path $appRoot "runtime\site-packages"
$frontendUrl = "http://127.0.0.1:3782"
$backendScriptPath = Join-Path $logDir "start-backend.cmd"
$frontendScriptPath = Join-Path $logDir "start-frontend.cmd"

New-Item -ItemType Directory -Force -Path $logDir | Out-Null

if (-not (Test-Path $envFile) -and (Test-Path $configTemplate)) {
    Copy-Item $configTemplate $envFile
}

function Get-Python312 {
    $py = Get-Command py.exe -ErrorAction SilentlyContinue
    if ($py) {
        try {
            $candidate = & $py.Source -3.12 -c "import sys; print(sys.executable)" 2>$null
            if ($LASTEXITCODE -eq 0 -and $candidate) {
                return $candidate.Trim()
            }
        } catch {
        }
    }

    $python = Get-Command python.exe -ErrorAction SilentlyContinue
    if ($python) {
        try {
            $version = & $python.Source -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')" 2>$null
            if ($LASTEXITCODE -eq 0 -and $version.Trim() -eq "3.12") {
                return $python.Source
            }
        } catch {
        }
    }

    return $null
}

function Test-FrontendReady {
    try {
        $response = Invoke-WebRequest -Uri $frontendUrl -UseBasicParsing -TimeoutSec 2
        return $response.StatusCode -ge 200 -and $response.StatusCode -lt 500
    } catch {
        return $false
    }
}

function Get-ListeningProcessCommandLine {
    param([Parameter(Mandatory = $true)][int]$Port)

    try {
        $connection = Get-NetTCPConnection -State Listen -LocalPort $Port -ErrorAction Stop |
            Select-Object -First 1
        if (-not $connection) {
            return $null
        }
        $process = Get-CimInstance Win32_Process -Filter "ProcessId = $($connection.OwningProcess)" -ErrorAction Stop
        return $process.CommandLine
    } catch {
        return $null
    }
}

function Test-CommandLineContains {
    param(
        [string]$CommandLine,
        [string]$Needle
    )

    if ([string]::IsNullOrWhiteSpace($CommandLine) -or [string]::IsNullOrWhiteSpace($Needle)) {
        return $false
    }

    return $CommandLine.IndexOf($Needle, [System.StringComparison]::OrdinalIgnoreCase) -ge 0
}

function Start-HiddenCmdProcess {
    param(
        [Parameter(Mandatory = $true)][string]$ScriptPath,
        [Parameter(Mandatory = $true)][string]$WorkingDirectory
    )

    Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "`"$ScriptPath`"" -WorkingDirectory $WorkingDirectory -WindowStyle Hidden | Out-Null
}

if (Test-FrontendReady) {
    $frontendOwner = Get-ListeningProcessCommandLine -Port 3782
    $backendOwner = Get-ListeningProcessCommandLine -Port 8001
    $isCurrentInstall =
        (Test-CommandLineContains -CommandLine $frontendOwner -Needle $frontendServer) -or
        (Test-CommandLineContains -CommandLine $backendOwner -Needle $appRoot)

    if ($isCurrentInstall) {
        Start-Process $frontendUrl | Out-Null
        exit 0
    }

    [System.Windows.MessageBox]::Show(
        "检测到 127.0.0.1:3782 已被其他 Bandu/DeepTutor 实例占用。请先关闭旧目录中的运行实例，再重新启动当前安装版。",
        "Bandu Launch Check"
    ) | Out-Null
    exit 1
}

$pythonExe = Get-Python312
if (-not $pythonExe) {
    [System.Windows.MessageBox]::Show("Bandu test build requires Python 3.12 on this machine. Please install Python 3.12 and try again.", "Bandu Launch Check") | Out-Null
    Start-Process "https://www.python.org/downloads/windows/" | Out-Null
    exit 1
}

if (-not (Test-Path $nodeExe)) {
    [System.Windows.MessageBox]::Show("Bundled Node runtime was not found. The frontend cannot be started.", "Bandu Launch Check") | Out-Null
    exit 1
}

if (-not (Test-Path $frontendServer)) {
    [System.Windows.MessageBox]::Show("Bundled frontend server file was not found. The frontend cannot be started.", "Bandu Launch Check") | Out-Null
    exit 1
}

$backendLog = Join-Path $logDir "backend.log"
$frontendLog = Join-Path $logDir "frontend.log"

$pythonPath = "$sitePackages;$appRoot"
$backendCmd = (@(
    '@echo off',
    'set PYTHONUNBUFFERED=1',
    "set PYTHONPATH=$pythonPath",
    "`"$pythonExe`" -m deeptutor.api.run_server >> `"$backendLog`" 2>&1"
) -join "`r`n")

$frontendCmd = (@(
    '@echo off',
    'set PORT=3782',
    'set HOSTNAME=127.0.0.1',
    'set NEXT_PUBLIC_API_BASE=http://127.0.0.1:8001',
    "`"$nodeExe`" `"$frontendServer`" >> `"$frontendLog`" 2>&1"
) -join "`r`n")

Set-Content -Path $backendScriptPath -Value $backendCmd -Encoding ASCII
Set-Content -Path $frontendScriptPath -Value $frontendCmd -Encoding ASCII

Start-HiddenCmdProcess -ScriptPath $backendScriptPath -WorkingDirectory $appRoot
Start-Sleep -Seconds 4
Start-HiddenCmdProcess -ScriptPath $frontendScriptPath -WorkingDirectory (Join-Path $appRoot "web")

for ($i = 0; $i -lt 20; $i++) {
    if (Test-FrontendReady) {
        Start-Process $frontendUrl | Out-Null
        exit 0
    }
    Start-Sleep -Seconds 1
}

[System.Windows.MessageBox]::Show("Bandu attempted to start, but the frontend did not become ready in time. Please check backend.log and frontend.log in the logs folder.", "Bandu Launch Check") | Out-Null
exit 1
