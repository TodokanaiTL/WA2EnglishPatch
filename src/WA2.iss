#include "WA2_functions.iss"

#ifndef VERSION
#define VERSION     "0.9.0.3"
#endif

#define EXEFILE     SourcePath + "..\bin\WA2_en.exe"
#define EXTER       "external skipifsourcedoesntexist"
#define POSTINS     "postinstall skipifsilent"

#define LINK_PATCH  "https://www.dropbox.com/s/dl/rkl4hwij4mshef2/en.pak"
#define LINK_EV000  "https://cloud.disroot.org/s/GSJAI3ImXkKyhTU/download"
#define LINK_EV150  "https://cloud.disroot.org/s/ytHgR2d9smdEobF/download"
#define LINK_MV010  "https://cloud.disroot.org/s/sRAzdd4ccW7lTok/download"
#define LINK_MV020  "https://cloud.disroot.org/s/3ogQTfqSrShs92j/download"
#define LINK_MV070  "https://cloud.disroot.org/s/FTF5wxZXOlPdEQx/download"
#define LINK_MV080  "https://cloud.disroot.org/s/SvvMcAjsTSy9z1H/download"
#define LINK_MV090  "https://cloud.disroot.org/s/b7DlHjPRgro8wyp/download"
#define LINK_MV200  "https://cloud.disroot.org/s/kDDSTHYUEi6wRP2/download"

#define HASH_EV000  "e71cd41b02705bd36044e8b381302143032dec90d57992a6c2462a7aed17689c"
#define HASH_EV150  "4d3cc8f0e9a633fd5fdbb422f1ca783fb1c627342489acbaed6df7d74fefeb2e"
#define HASH_MV010  "7d944777fd7bc6039cf0309aca962170cd9c40e4385b353a983e771cb916aa6f"
#define HASH_MV020  "58e62c0e6b15c134fbff8c664ae4a64d8d9ad778569990ffca1452ea786be0f9"
#define HASH_MV070  "bc8016d9b0ff79e01e0d6d658f012b3af3f5c459df6523b6b000979aeb9473bf"
#define HASH_MV080  "8171f8f3376b0b014f0425f77ee1e3bb6979b491dba3957bed8b40ecf89d4c39"
#define HASH_MV090  "07f531ed870b588103fff9e17d6b7919b8b67f1c8db90fb0266ad7e81590ad79"
#define HASH_MV200  "5780af7c1d67066951810d1512519531202a178331db0e508ba968fe1ac7e904"

#define SIZE_EV000  "002705594"
#define SIZE_EV150  "089832107"
#define SIZE_MV010  "014158612"
#define SIZE_MV020  "215714284"
#define SIZE_MV070  "014616236"
#define SIZE_MV080  "189675944"
#define SIZE_MV090  "230576002"
#define SIZE_MV200  "189387890"

[Setup]
; App info
AppId = {{89357994-3C15-4411-894D-A23CE3FF1AA1}
AppName = White Album 2 English
AppVersion = {#VERSION}
AppPublisher = Todokanai TL
AppCopyright = Copyright (C) 2017-2021, Todokanai TL
AppPublisherURL = https://todokanaitl.github.io
AppSupportURL = https://discord.gg/5rrxEUN
VersionInfoVersion = {#VERSION}
VersionInfoDescription = White Album 2 English Patch

; Output
OutputDir = {#SourcePath}..\out
#ifdef IS_DMM
OutputBaseFilename = WA2_patch_DMM
#else
OutputBaseFilename = WA2_patch
#endif

; Included files
LicenseFile = {#SourcePath}..\LICENSE
InfoBeforeFile = {#SourcePath}..\res\Instructions.rtf
InfoAfterFile = {#SourcePath}..\res\ReleaseNotes.rtf
SetupIconFile = {#SourcePath}..\res\logo.ico

; Compression
Compression = bzip/9
SolidCompression = yes

; Installation
DefaultDirName = {src}
AppendDefaultDirName = no
UsePreviousAppDir = yes
PrivilegesRequired = admin
UsedUserAreasWarning = no
AllowCancelDuringInstall = yes
DisableProgramGroupPage = yes
EnableDirDoesntExistWarning = yes
DirExistsWarning = no
ArchitecturesAllowed = x86 x64
ArchitecturesInstallIn64BitMode = x64

; Misc
Uninstallable = no
TimeStampsInUTC = yes
SetupLogging = yes
DefaultDialogFontName = Lucida Sans Unicode
WizardStyle = modern

[Languages]
; Setup language
Name: "English"; MessagesFile: "compiler:Default.isl"

[InstallDelete]
; Delete obsolete files
Type: files;          Name: "{app}\patch.pak"
Type: files;          Name: "{app}\ev200.pak"
Type: files;          Name: "{app}\IC\ev200.pak"
Type: files;          Name: "{app}\IC\ev010.pak"
Type: files;          Name: "{app}\IC\ev020.pak"
Type: files;          Name: "{app}\IC\ev070.pak"
Type: files;          Name: "{app}\IC\ev080.pak"
Type: files;          Name: "{app}\IC\ev090.pak"
Type: filesandordirs; Name: "{userdocs}\White Album 2 Patch Logs"

[Components]
; Installation components
Name: "patch";        Description: "English patch";    Types: full compact custom; Flags: fixed
Name: "desktopicon";  Description: "Desktop shortcut"; Types: full compact
Name: "videos";       Description: "Subbed videos";    Types: full
Name: "videos\mv200"; Description: "mv200";            Types: full
Name: "videos\mv010"; Description: "mv010";            Types: full
Name: "videos\mv020"; Description: "mv020";            Types: full
Name: "videos\mv070"; Description: "mv070";            Types: full
Name: "videos\mv080"; Description: "mv080";            Types: full
Name: "videos\mv090"; Description: "mv090";            Types: full

[Dirs]
; Directories
Name: "{app}\IC"; Components: videos

[Icons]
; Desktop shortcut
Name: "{commondesktop}\White Album 2"; Filename: "{app}\WA2_en.exe"; Components: desktopicon

[INI]
; Edit SYSTEM.ini
Filename: "{userdocs}\Leaf\WHITE ALBUM2\SYSTEM.ini"; Section: "DEFAULT"; Key: "mov_lv"; String: 2

[Run]
; Postinstall options
Filename: "{log}";            Description: Open log file; Flags: {#POSTINS} unchecked shellexec
Filename: "{app}\WA2_en.exe"; Description: Launch game;   Flags: {#POSTINS} nowait

[Files]
; Executable
Source: "{#EXEFILE}";      DestDir: "{app}";    Components: patch;        Flags: ignoreversion

; Patch files
Source: "{tmp}\en.pak";    DestDir: "{app}";    Components: patch;        Flags: {#EXTER} ignoreversion
Source: "{tmp}\ev000.pak"; DestDir: "{app}";    Components: patch;        Flags: {#EXTER}; ExternalSize: {#SIZE_EV000}
Source: "{tmp}\ev150.pak"; DestDir: "{app}";    Components: patch;        Flags: {#EXTER}; ExternalSize: {#SIZE_EV150}

; IC Videos
Source: "{tmp}\mv010.pak"; DestDir: "{app}\IC"; Components: videos\mv010; Flags: {#EXTER}; ExternalSize: {#SIZE_MV010}
Source: "{tmp}\mv020.pak"; DestDir: "{app}\IC"; Components: videos\mv020; Flags: {#EXTER}; ExternalSize: {#SIZE_MV020}
Source: "{tmp}\mv070.pak"; DestDir: "{app}\IC"; Components: videos\mv070; Flags: {#EXTER}; ExternalSize: {#SIZE_MV070}
Source: "{tmp}\mv080.pak"; DestDir: "{app}\IC"; Components: videos\mv080; Flags: {#EXTER}; ExternalSize: {#SIZE_MV080}
Source: "{tmp}\mv090.pak"; DestDir: "{app}\IC"; Components: videos\mv090; Flags: {#EXTER}; ExternalSize: {#SIZE_MV090}

; CC Videos
Source: "{tmp}\mv200.pak"; DestDir: "{app}";    Components: videos\mv200; Flags: {#EXTER}; ExternalSize: {#SIZE_MV200}

[Code]
var
  DownloadPage:  TDownloadWizardPage;
#ifndef IS_DMM
  folder:        String;
#endif

function InitializeSetup(): Boolean;
begin
#ifndef IS_DMM
  if not IsInstalled() then begin
    MsgBox('You have to install the original game ' + \
      'before applying the patch!', mbCriticalError, MB_OK);
    Result := False;
    ExitProcess(3);
  end;
#endif

  Result := True;
end;

procedure InitializeWizard();
begin
  WizardForm.LicenseAcceptedRadio.Checked := True;
#ifndef IS_DMM
  if GetInstallDir(folder) then WizardForm.DirEdit.Text := folder;
#endif
  DownloadPage := CreateDownloadPage( \
    SetupMessage(msgWizardPreparing), \
    SetupMessage(msgPreparingDesc), nil);
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = wpReady then begin
    Log('-- Downloading files --');
    DownloadPage.Clear;
    DownloadPage.Add('{#LINK_PATCH}', 'en.pak', '');
    if not FileExists(ExpandConstant('{app}\ev000.pak')) then
      DownloadPage.Add('{#LINK_EV000}', 'ev000.pak', '{#HASH_EV000}');
    if not FileExists(ExpandConstant('{app}\ev150.pak')) then
      DownloadPage.Add('{#LINK_EV150}', 'ev150.pak', '{#HASH_EV150}');
    if WizardIsComponentSelected('videos') then begin
      if PrepareDownload('{app}\', 'mv200.pak', 'videos\mv200') then
        DownloadPage.Add('{#LINK_MV200}', 'mv200.pak', '{#HASH_MV200}');
      if PrepareDownload('{app}\IC\', 'mv010.pak', 'videos\mv010') then
        DownloadPage.Add('{#LINK_MV010}', 'mv010.pak', '{#HASH_MV010}');
      if PrepareDownload('{app}\IC\', 'mv020.pak', 'videos\mv020') then
        DownloadPage.Add('{#LINK_MV020}', 'mv020.pak', '{#HASH_MV020}');
      if PrepareDownload('{app}\IC\', 'mv070.pak', 'videos\mv070') then
        DownloadPage.Add('{#LINK_MV070}', 'mv070.pak', '{#HASH_MV070}');
      if PrepareDownload('{app}\IC\', 'mv080.pak', 'videos\mv080') then
        DownloadPage.Add('{#LINK_MV080}', 'mv080.pak', '{#HASH_MV080}');
      if PrepareDownload('{app}\IC\', 'mv090.pak', 'videos\mv090') then
        DownloadPage.Add('{#LINK_MV090}', 'mv090.pak', '{#HASH_MV090}');
    end else begin
      Log('No videos have been selected.');
    end;
    DownloadPage.Show;
    try
      DownloadPage.Download;
    except
      Result := False;
      MsgBox(GetExceptionMessage, mbCriticalError, MB_OK);
    finally
      DownloadPage.Hide;
    end;
  end;
end;
