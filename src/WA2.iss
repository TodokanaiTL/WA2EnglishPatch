#include <idp.iss>
#include "WA2_functions.iss"

#define AppName       "White Album 2 English"
#define AppVersion    "0.8.4.7"
#define AppPublisher  "Todokanai TL"
#define AppCopyright  "Copyright (C) 2017, Todokanai TL"
#define AppURL        "https://todokanaitl.wordpress.com"
#define AppExeName    "WA2_en.exe"
#define AppFileName   "WA2_patch"

#define ExterFlags    "external skipifsourcedoesntexist"
#define PostInFlags   "postinstall skipifsilent"
#define LogFolder     "{userdocs}\White Album 2 Patch Logs" 
#define SubV          "subbedvideos\"

#define MD5_WA2       "1397bb8a72d95b81b92673601660cbd0"
#define MD5_EV000     "1a66cec0f63148a8baf0458e5c3d4675"
#define MD5_EV150     "de60616ee1641856070e454bea596d83"
#define MD5_MV200     "2f605315223d7691244189b94b2b13d3"
#define MD5_MV010     "797623b4fd9e1587a7757333f88e340c"
#define MD5_MV020     "2195ee1069d1bf2fc7f7fb59109386d8"
#define MD5_MV070     "f6c477dfbe1767e0a70554cb40e1e27b"
#define MD5_MV080     "1890b98d6690f434ab8f7e3fdb37d998"
#define MD5_MV090     "2e397a50d035e263aa1360062114268a"

[Setup]
AppId = {{89357994-3C15-4411-894D-A23CE3FF1AA1}
AppName = {#AppName}
AppVersion = {#AppVersion}
AppVerName = {#AppFileName} {#AppVersion}
AppPublisher = {#AppPublisher}
AppPublisherURL = {#AppURL}
AppSupportURL = {#AppURL}/contact
AppUpdatesURL = {#AppURL}/patch
AppCopyright = {#AppCopyright}
DefaultGroupName = {#AppName}
OutputBaseFilename = {#AppFileName}
OutputDir = {#SourcePath}..\out
VersionInfoVersion = {#AppVersion}
VersionInfoDescription = {#Appname} Patch
VersionInfoCopyright = {#AppCopyright}
LicenseFile = {#SourcePath}..\LICENSE
InfoBeforeFile = {#SourcePath}..\docs\Instructions.rtf
InfoAfterFile = {#SourcePath}..\docs\Release Notes.rtf
SetupIconFile = {#SourcePath}..\icons\logo.ico
PrivilegesRequired = admin 
Compression = lzma2/ultra
LZMAUseSeparateProcess = yes
LZMADictionarySize = 524288  
LZMANumFastBytes = 273
SolidCompression = yes
DefaultDirName = {src}
;UsePreviousAppDir = yes
AppendDefaultDirName = no
TimeStampsInUTC = yes
AllowCancelDuringInstall = yes
DisableProgramGroupPage = yes
DirExistsWarning = no
Uninstallable = no
SetupLogging = yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[InstallDelete]
;Delete obsolete files
Type: files; Name: "{app}\patch.pak"
Type: files; Name: "{app}\ev200.pak"
Type: files; Name: "{app}\IC\ev200.pak"
Type: files; Name: "{app}\IC\ev010.pak"
Type: files; Name: "{app}\IC\ev020.pak"
Type: files; Name: "{app}\IC\ev070.pak"
Type: files; Name: "{app}\IC\ev080.pak"
Type: files; Name: "{app}\IC\ev090.pak"

[Components]
Name: "patch";        Description: "English patch";    Types: full compact custom; Flags: fixed
Name: "desktopicon";  Description: "Desktop shortcut"; Types: full compact
Name: "subbedvideos"; Description: "Subbed videos";    Types: full
Name: "{#SubV}mv200"; Description: "mv200";            Types: full 
Name: "{#SubV}mv010"; Description: "mv010";            Types: full
Name: "{#SubV}mv020"; Description: "mv020";            Types: full
Name: "{#SubV}mv070"; Description: "mv070";            Types: full
Name: "{#SubV}mv080"; Description: "mv080";            Types: full
Name: "{#SubV}mv090"; Description: "mv090";            Types: full

[Dirs]
Name: "{app}\IC"; Components: subbedvideos
Name: "{#LogFolder}"

[Icons]
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Components: desktopicon

[Run]
Filename: "{#LogFolder}";        Description: Open log folder; Flags: {#PostInFlags} unchecked shellexec
Filename: "{app}\{#AppExeName}"; Description: Launch game;     Flags: {#PostInFlags} nowait
   
[Files]
Source: "{#SourcePath}..\bin\WA2_en.exe"; DestDir: "{app}"; Components: patch

;Patch Files
Source: "{tmp}\en.pak";    DestDir: "{app}"; Components: patch; Flags: {#ExterFlags} ignoreversion;
Source: "{tmp}\ev000.pak"; DestDir: "{app}"; Components: patch; Flags: {#ExterFlags}; ExternalSize:  002707456
Source: "{tmp}\ev150.pak"; DestDir: "{app}"; Components: patch; Flags: {#ExterFlags}; ExternalSize:  114393088

;Videos CC
Source: "{tmp}\mv200.pak"; DestDir: "{app}";    Components: {#SubV}mv200; Flags: {#ExterFlags}; ExternalSize: 189390848 

;Videos IC
Source: "{tmp}\mv010.pak"; DestDir: "{app}\IC"; Components: {#SubV}mv010; Flags: {#ExterFlags}; ExternalSize: 014159872
Source: "{tmp}\mv020.pak"; DestDir: "{app}\IC"; Components: {#SubV}mv020; Flags: {#ExterFlags}; ExternalSize: 215715840 
Source: "{tmp}\mv070.pak"; DestDir: "{app}\IC"; Components: {#SubV}mv070; Flags: {#ExterFlags}; ExternalSize: 014618624 
Source: "{tmp}\mv080.pak"; DestDir: "{app}\IC"; Components: {#SubV}mv080; Flags: {#ExterFlags}; ExternalSize: 189677568 
Source: "{tmp}\mv090.pak"; DestDir: "{app}\IC"; Components: {#SubV}mv090; Flags: {#ExterFlags}; ExternalSize: 230576128 

[Code]
var
  DateAndTime: String;
  appIsSet: Boolean;
  wasCancelled: Boolean;
#ifndef _DL_
#define _DL_
  ev000_DL, ev150_DL: Boolean;
#endif

function InitializeSetup(): Boolean;
begin
  try
    DateAndTime := CurDateTime();
  except
    ShowExceptionMessage;
  end;
  
  try
    appIsSet := False;
  except
    ShowExceptionMessage;
  end;
  
  try
    wasCancelled := False;
  except
    ShowExceptionMessage;
  end;

  if  not RegKeyExists(HKLM64, 'Software\Leaf\WHITE ALBUM2') \
  and not RegKeyExists(HKLM32, 'Software\Leaf\WHITE ALBUM2') \
  and not RegKeyExists(HKCU,   'Software\Leaf\WHITE ALBUM2') then begin
    MsgBox('You have to install the original game before applying the patch!', mbCriticalError, MB_OK);
    Result := False;
  end;

  Result := True;
end;        

procedure InitializeWizard;
begin
  WizardForm.LicenseAcceptedRadio.Checked := True;
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  try
    wasCancelled := True;
  except
    ShowExceptionMessage();
  end;
end;
  
procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpSelectDir then appIsSet := True;

  if CurPageID = wpReady then begin
    Log('-- Initializing downloads --');
    idpSetOption('DetailedMode',   'True');
    idpSetOption('ConnectTimeout', 'Infinite');
    idpSetOption('ReceiveTimeout', 'Infinite');
    idpSetOption('SendTimeout',    'Infinite');

    Log('Downloading en.pak.');
    idpAddFile('https://www.dropbox.com/s/rkl4hwij4mshef2/en.pak?dl=1', ExpandConstant('{tmp}\en.pak'));

    DownloadPatchFile('https://www.dropbox.com/s/kkw5xaxq177yu49/ev000.pak?dl=1', 'ev000', 002707456);
    DownloadPatchFile('https://www.dropbox.com/s/9mcw7evymo6sbx0/ev150.pak?dl=1', 'ev150', 114393088);

    if IsComponentSelected('subbedvideos') then begin
      {* Closing Chapter *}
      {* mv200 *}
      DownloadVideoCC('https://www.dropbox.com/s/stoszrny6akbrhz/ev200.pak?dl=1', 'mv200', 189390848);

      {* Introductory Chapter *}
      {* mv010 *}
      DownloadVideoIC('https://www.dropbox.com/s/768bz4ohx3otik7/ev010.pak?dl=1', 'mv010', 014159872);
      {* mv020 *}
      DownloadVideoIC('https://www.dropbox.com/s/9kcjcicodjtd7gj/ev020.pak?dl=1', 'mv020', 215715840);
      {* mv070 *}
      DownloadVideoIC('https://www.dropbox.com/s/co5upv8f1ocw7m3/ev070.pak?dl=1', 'mv070', 014618624);
      {* mv080 *}
      DownloadVideoIC('https://www.dropbox.com/s/hn57kfgrpzqbpoa/ev080.pak?dl=1', 'mv080', 189677568);
      {* mv090 *}
      DownloadVideoIC('https://www.dropbox.com/s/012laiv3ycm2quk/ev090.pak?dl=1', 'mv090', 230576128);
    end else begin
      Log('No subbed videos have been selected.');
    end;    
    Log('Downloading ' + IntToStr(idpFilesCount) + ' file(s).'); 
    idpDownloadAfter(wpReady);  
  end;

  if CurPageID = wpInfoAfter then begin
    Log('-- Verifying MD5 hashes --');
    LogMD5CC('en.pak', '');
    LogMD5CC('WA2_en.exe', '{#MD5_WA2}');
    if ev000_DL then LogMD5CC('ev000.pak', '{#MD5_EV000}');
    if ev150_DL then LogMD5CC('ev150.pak', '{#MD5_EV150}');
    if IsComponentSelected('{#SubV}mv200') then LogMD5CC('mv200.pak', '{#MD5_MV200}');
    if IsComponentSelected('{#SubV}mv010') then LogMD5IC('mv010.pak', '{#MD5_MV010}');
    if IsComponentSelected('{#SubV}mv020') then LogMD5IC('mv020.pak', '{#MD5_MV020}');
    if IsComponentSelected('{#SubV}mv070') then LogMD5IC('mv070.pak', '{#MD5_MV070}');
    if IsComponentSelected('{#SubV}mv080') then LogMD5IC('mv080.pak', '{#MD5_MV080}');
    if IsComponentSelected('{#SubV}mv090') then LogMD5IC('mv090.pak', '{#MD5_MV090}');
  end;
end;

procedure DeinitializeSetup();
begin
  if appIsSet and not wasCancelled then Log('Setup completed.');

  FileCopy(ExpandConstant('{log}'), ExpandConstant('{userdocs}\White Album 2 Patch Logs\') + 'WA2_Patch_Log_' + DateAndTime + '.log', False);
  RestartReplace(ExpandConstant('{log}'), '');
end;
