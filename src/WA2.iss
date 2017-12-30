#include <idp.iss>
#include "WA2_functions.iss"

#define LOGDIR     "{userdocs}\White Album 2 Patch Logs"
#define EXTER      "external skipifsourcedoesntexist"
#define POSTINS    "postinstall skipifsilent"

#define MD5_WA2    "795748323bbc77fdb88b3bc9a2929477"
#define MD5_EV000  "1a66cec0f63148a8baf0458e5c3d4675"
#define MD5_EV150  "de60616ee1641856070e454bea596d83"
#define MD5_MV200  "2f605315223d7691244189b94b2b13d3"
#define MD5_MV010  "797623b4fd9e1587a7757333f88e340c"
#define MD5_MV020  "2195ee1069d1bf2fc7f7fb59109386d8"
#define MD5_MV070  "f6c477dfbe1767e0a70554cb40e1e27b"
#define MD5_MV080  "1890b98d6690f434ab8f7e3fdb37d998"
#define MD5_MV090  "2e397a50d035e263aa1360062114268a"

[Setup]
; App info
AppId = {{89357994-3C15-4411-894D-A23CE3FF1AA1}
AppName = White Album 2 English
AppVersion = 0.8.5.2
AppPublisher = Todokanai TL
AppCopyright = Copyright (C) 2017, Todokanai TL
AppPublisherURL = https://todokanaitl.wordpress.com
AppSupportURL = https://discord.me/TodokanaiTL
VersionInfoVersion = 0.8.5.2
VersionInfoDescription = White Album 2 English Patch

; Output
OutputDir = {#SourcePath}..\out
OutputBaseFilename = WA2_patch

; Included files
LicenseFile = {#SourcePath}..\LICENSE
InfoBeforeFile = {#SourcePath}..\docs\Instructions.rtf
InfoAfterFile = {#SourcePath}..\docs\Release Notes.rtf
SetupIconFile = {#SourcePath}..\icons\logo.ico

; Compression
Compression = lzma2/ultra
InternalCompressLevel = ultra
LZMAUseSeparateProcess = yes
LZMADictionarySize = 524288
LZMANumFastBytes = 273
SolidCompression = yes

; Installation
DefaultDirName = {src}
AppendDefaultDirName = no
UsePreviousAppDir = yes
PrivilegesRequired = admin
AllowCancelDuringInstall = yes
DisableProgramGroupPage = yes
EnableDirDoesntExistWarning = yes
DirExistsWarning = no

; Misc
Uninstallable = no
TimeStampsInUTC = yes
SetupLogging = yes
DefaultDialogFontName = Lucida Sans Unicode

[Languages]
; Setup language
Name: "English"; MessagesFile: "compiler:Default.isl"

[InstallDelete]
; Delete obsolete files
Type: files; Name: "{app}\patch.pak"
Type: files; Name: "{app}\ev200.pak"
Type: files; Name: "{app}\IC\ev200.pak"
Type: files; Name: "{app}\IC\ev010.pak"
Type: files; Name: "{app}\IC\ev020.pak"
Type: files; Name: "{app}\IC\ev070.pak"
Type: files; Name: "{app}\IC\ev080.pak"
Type: files; Name: "{app}\IC\ev090.pak"

[Components]
; Installation components
Name: "patch";              Description: "English patch";    Types: full compact custom; Flags: fixed
Name: "desktopicon";        Description: "Desktop shortcut"; Types: full compact
Name: "subbedvideos";       Description: "Subbed videos";    Types: full
Name: "subbedvideos\mv200"; Description: "mv200";            Types: full
Name: "subbedvideos\mv010"; Description: "mv010";            Types: full
Name: "subbedvideos\mv020"; Description: "mv020";            Types: full
Name: "subbedvideos\mv070"; Description: "mv070";            Types: full
Name: "subbedvideos\mv080"; Description: "mv080";            Types: full
Name: "subbedvideos\mv090"; Description: "mv090";            Types: full

[Dirs]
; Directories
Name: "{app}\IC"; Components: subbedvideos
Name: "{#LOGDIR}"

[Icons]
; Desktop shortcut
Name: "{commondesktop}\White Album 2"; Filename: "{app}\WA2_en.exe"; Components: desktopicon

[Run]
; Postinstall options
Filename: "{#LOGDIR}";        Description: Open log folder; Flags: {#POSTINS} unchecked shellexec
Filename: "{app}\WA2_en.exe"; Description: Launch game;     Flags: {#POSTINS} nowait

[Files]
; Executable
Source: "{#SourcePath}..\bin\WA2_en.exe"; DestDir: "{app}"; Components: patch

; Patch files
Source: "{tmp}\en.pak";    DestDir: "{app}"; Components: patch; Flags: {#EXTER} ignoreversion;
Source: "{tmp}\ev000.pak"; DestDir: "{app}"; Components: patch; Flags: {#EXTER}; ExternalSize:  002707456
Source: "{tmp}\ev150.pak"; DestDir: "{app}"; Components: patch; Flags: {#EXTER}; ExternalSize:  114393088

; Videos CC
Source: "{tmp}\mv200.pak"; DestDir: "{app}";    Components: subbedvideos\mv200; Flags: {#EXTER}; ExternalSize: 189390848

; Videos IC
Source: "{tmp}\mv010.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv010; Flags: {#EXTER}; ExternalSize: 014159872
Source: "{tmp}\mv020.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv020; Flags: {#EXTER}; ExternalSize: 215715840
Source: "{tmp}\mv070.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv070; Flags: {#EXTER}; ExternalSize: 014618624
Source: "{tmp}\mv080.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv080; Flags: {#EXTER}; ExternalSize: 189677568
Source: "{tmp}\mv090.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv090; Flags: {#EXTER}; ExternalSize: 230576128

[Code]
var
  DateAndTime: String;
  appIsSet: Boolean;
  wasCancelled: Boolean;
  ev000_DL, ev150_DL,
  mv200_DL, mv010_DL,
  mv020_DL, mv070_DL,
  mv080_DL, mv090_DL: Boolean;

function InitializeSetup(): Boolean;
begin
  try
    DateAndTime := GetDateTimeString('yyyy-mm-dd_hh.nn.ss', '-', '.');
  except
    ShowExceptionMessage;
  end;

  appIsSet := False;
  wasCancelled := False;

  if  not RegKeyExists(GetHKLM, 'Software\Leaf\WHITE ALBUM2') \
  and not RegKeyExists(HKCU,    'Software\Leaf\WHITE ALBUM2') then begin
    MsgBox('You have to install the original game before applying the patch!', mbCriticalError, MB_OK);
    Result := False;
  end else begin
    Result := True;
  end

end;

procedure InitializeWizard;
begin
  WizardForm.LicenseAcceptedRadio.Checked := True;
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  wasCancelled := True;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpSelectDir then appIsSet := True;

  if CurPageID = wpReady then begin
    Log('-- Initializing downloads --');
    idpSetOption('RetryButton',    '0');
    idpSetOption('DetailedMode',   '1');
    idpSetOption('AllowContinue',  '1');
    idpSetOption('ErrorDialog',    'FileList');
    idpSetOption('UserAgent',      'WA2EN/0.8.4.9');

    Log('Downloading en.pak.');
    idpAddFile('https://www.dropbox.com/s/rkl4hwij4mshef2/en.pak?dl=1', ExpandConstant('{tmp}\en.pak'));

    if DownloadPatchFile('https://cloud.disroot.org/s/GSJAI3ImXkKyhTU/download', 'ev000', 002707456)
    then ev000_DL := True;
    if DownloadPatchFile('https://cloud.disroot.org/s/tB0sd3IXMdKGW0H/download', 'ev150', 114393088)
    then ev150_DL := True;

    if IsComponentSelected('subbedvideos') then begin
      {* Closing Chapter *}
      {* mv200 *}
      if DownloadVideoCC('https://cloud.disroot.org/s/kDDSTHYUEi6wRP2/download', 'mv200', 189390848)
      then mv200_DL := True;

      {* Introductory Chapter *}
      {* mv010 *}
      if DownloadVideoIC('https://cloud.disroot.org/s/sRAzdd4ccW7lTok/download', 'mv010', 014159872)
      then mv010_DL := True;
      {* mv020 *}
      if DownloadVideoIC('https://cloud.disroot.org/s/3ogQTfqSrShs92j/download', 'mv020', 215715840)
      then mv020_DL := True;
      {* mv070 *}
      if DownloadVideoIC('https://cloud.disroot.org/s/FTF5wxZXOlPdEQx/download', 'mv070', 014618624)
      then mv070_DL := True;
      {* mv080 *}
      if DownloadVideoIC('https://cloud.disroot.org/s/SvvMcAjsTSy9z1H/download', 'mv080', 189677568)
      then mv080_DL := True;
      {* mv090 *}
      if DownloadVideoIC('https://cloud.disroot.org/s/b7DlHjPRgro8wyp/download', 'mv090', 230576128)
      then mv080_DL := True;
    end else begin
      Log('No subbed videos have been selected.');
    end;

    Log('Downloading ' + IntToStr(idpFilesCount) + ' file(s).');
    idpDownloadAfter(wpReady);
  end;

  if CurPageID = wpFinished then begin
    Log('-- Verifying MD5 hashes --');
    LogMD5CC('en.pak', '');
    LogMD5CC('WA2_en.exe', '{#MD5_WA2}');
    if ev000_DL then LogMD5CC('ev000.pak', '{#MD5_EV000}');
    if ev150_DL then LogMD5CC('ev150.pak', '{#MD5_EV150}');
    if mv200_DL then LogMD5CC('mv200.pak', '{#MD5_MV200}');
    if mv010_DL then LogMD5IC('mv010.pak', '{#MD5_MV010}');
    if mv020_DL then LogMD5IC('mv020.pak', '{#MD5_MV020}');
    if mv070_DL then LogMD5IC('mv070.pak', '{#MD5_MV070}');
    if mv080_DL then LogMD5IC('mv080.pak', '{#MD5_MV080}');
    if mv090_DL then LogMD5IC('mv090.pak', '{#MD5_MV090}');
  end;
end;

procedure DeinitializeSetup();
begin
  if appIsSet and not wasCancelled then Log('Setup completed.');

  FileCopy(ExpandConstant('{log}'), ExpandConstant('{userdocs}\White Album 2 Patch Logs\') + 'WA2_Patch_Log_' + DateAndTime + '.log', False);
  RestartReplace(ExpandConstant('{log}'), '');
end;
