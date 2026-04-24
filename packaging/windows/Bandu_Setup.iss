#define MyAppName "Bandu"
#define MyAppVersion "1.0.2-local"
#define MyAppPublisher "Bandu"
#define MyAppContact "36034729@qq.com"
#define MyAppExeName "Launch Bandu.bat"
#define MyStagingDir "..\..\output\staging\Bandu"

[Setup]
AppId={{8E051099-3225-4BE4-BDB7-AC482621B4CE}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppComments=Community-maintained derivative build. Contact: {#MyAppContact}
DefaultDirName={localappdata}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=..\..\LICENSE
InfoBeforeFile=INSTALLER_NOTICE_CN.txt
SetupIconFile=Bandu.ico
OutputDir=..\..\output\installer
OutputBaseFilename=Bandu_Setup_1.0.2_local_source_snapshot
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
SetupLogging=yes
UninstallDisplayName={#MyAppName} (Derivative Build)
UninstallDisplayIcon={app}\Bandu.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "{#MyStagingDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\..\LICENSE"; DestDir: "{app}\legal"; Flags: ignoreversion
Source: "..\..\NOTICE"; DestDir: "{app}\legal"; Flags: ignoreversion
Source: "..\..\MODIFICATIONS.md"; DestDir: "{app}\legal"; Flags: ignoreversion
Source: "..\..\THIRD_PARTY_LICENSES.md"; DestDir: "{app}\legal"; Flags: ignoreversion
Source: "..\..\packaging\windows\INSTALLER_NOTICE.txt"; DestDir: "{app}\legal"; Flags: ignoreversion
Source: "..\..\packaging\windows\INSTALLER_NOTICE_CN.txt"; DestDir: "{app}\legal"; Flags: ignoreversion
Source: "..\..\README.md"; DestDir: "{app}\docs"; Flags: ignoreversion
Source: "..\..\.env.example"; DestDir: "{app}\config-examples"; Flags: ignoreversion
Source: "..\..\.env.example_CN"; DestDir: "{app}\config-examples"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Bandu.ico"; Check: FileExists(ExpandConstant('{app}\{#MyAppExeName}'))
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\Bandu.ico"; Tasks: desktopicon; Check: FileExists(ExpandConstant('{app}\{#MyAppExeName}'))
Name: "{autoprograms}\{#MyAppName}\License"; Filename: "{app}\legal\LICENSE"
Name: "{autoprograms}\{#MyAppName}\Derivative Notice"; Filename: "{app}\legal\NOTICE"
Name: "{autoprograms}\{#MyAppName}\Modifications"; Filename: "{app}\legal\MODIFICATIONS.md"
Name: "{autoprograms}\{#MyAppName}\Third-Party Licenses"; Filename: "{app}\legal\THIRD_PARTY_LICENSES.md"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent; Check: FileExists(ExpandConstant('{app}\{#MyAppExeName}'))
