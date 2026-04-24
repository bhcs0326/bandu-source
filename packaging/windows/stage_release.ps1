$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$releaseRoot = Join-Path $repoRoot "output"
$stagingRoot = Join-Path $releaseRoot "staging\\Bandu"
$outputRoot = Join-Path $releaseRoot "installer"
$logsRoot = Join-Path $releaseRoot "logs"

function Reset-Directory {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (Test-Path $Path) {
        $resolved = (Resolve-Path $Path).Path
        $allowedRoot = (Resolve-Path $releaseRoot).Path
        if (-not $resolved.StartsWith($allowedRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing to remove unexpected path: $resolved"
        }
        Remove-Item -LiteralPath $resolved -Recurse -Force
    }
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
}

function Copy-Tree {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Destination
    )

    New-Item -ItemType Directory -Force -Path $Destination | Out-Null
    Copy-Item -Path (Join-Path $Source "*") -Destination $Destination -Recurse -Force
}

Reset-Directory -Path $stagingRoot
New-Item -ItemType Directory -Force -Path $outputRoot, $logsRoot | Out-Null

$dirsToCopy = @(
    @{ Source = (Join-Path $repoRoot "deeptutor"); Destination = (Join-Path $stagingRoot "deeptutor") },
    @{ Source = (Join-Path $repoRoot "deeptutor_cli"); Destination = (Join-Path $stagingRoot "deeptutor_cli") },
    @{ Source = (Join-Path $repoRoot ".venv\\Lib\\site-packages"); Destination = (Join-Path $stagingRoot "runtime\\site-packages") },
    @{ Source = (Join-Path $repoRoot "web\\.next\\standalone"); Destination = (Join-Path $stagingRoot "web") },
    @{ Source = (Join-Path $repoRoot "web\\.next\\static"); Destination = (Join-Path $stagingRoot "web\\.next\\static") },
    @{ Source = (Join-Path $repoRoot "web\\public"); Destination = (Join-Path $stagingRoot "web\\public") }
)

foreach ($entry in $dirsToCopy) {
    if (-not (Test-Path $entry.Source)) {
        throw "Missing required source path: $($entry.Source)"
    }
    Copy-Tree -Source $entry.Source -Destination $entry.Destination
}

$nodeSource = (Get-Command node.exe -ErrorAction Stop).Source
$singleFiles = @(
    @{ Source = $nodeSource; Destination = (Join-Path $stagingRoot "runtime\\node\\node.exe") },
    @{ Source = (Join-Path $repoRoot "packaging\\windows\\Launch Bandu.bat"); Destination = (Join-Path $stagingRoot "Launch Bandu.bat") },
    @{ Source = (Join-Path $repoRoot "packaging\\windows\\Bandu_Launcher.ps1"); Destination = (Join-Path $stagingRoot "Bandu_Launcher.ps1") },
    @{ Source = (Join-Path $repoRoot "packaging\\windows\\Bandu.ico"); Destination = (Join-Path $stagingRoot "Bandu.ico") },
    @{ Source = (Join-Path $repoRoot ".env.example"); Destination = (Join-Path $stagingRoot "config-examples\\.env.example") },
    @{ Source = (Join-Path $repoRoot ".env.example_CN"); Destination = (Join-Path $stagingRoot "config-examples\\.env.example_CN") },
    @{ Source = (Join-Path $repoRoot "README.md"); Destination = (Join-Path $stagingRoot "docs\\README.md") }
)

foreach ($entry in $singleFiles) {
    if (-not (Test-Path $entry.Source)) {
        throw "Missing required source file: $($entry.Source)"
    }
    $parent = Split-Path -Parent $entry.Destination
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
    Copy-Item -LiteralPath $entry.Source -Destination $entry.Destination -Force
}

Get-ChildItem -Path $stagingRoot -Recurse -Directory -Filter "__pycache__" | Remove-Item -Recurse -Force
Get-ChildItem -Path $stagingRoot -Recurse -File -Include "*.pyc", "*.pyo" | Remove-Item -Force

Write-Host "Staging complete: $stagingRoot"
Write-Host "Installer output: $outputRoot"
