#include <idp.iss>
#include "WA2_functions.iss"

#define AppName "White Album 2 English"
#define AppVersion "0.8.4.3"
#define AppPublisher "Todokanai TL"
#define AppURL "https://todokanaitl.wordpress.com"
#define AppExeName "WA2_en.exe"
#define AppFileName "WA2_patch"
#define ExterFlags "external skipifsourcedoesntexist"
#define SubV "subbedvideos\"

[Setup]
AppId = {{89357994-3C15-4411-894D-A23CE3FF1AA1}
AppName = {#AppName}
AppVersion = {#AppVersion}
AppVerName = {#AppFileName} {#AppVersion}
AppPublisher = {#AppPublisher}
AppPublisherURL = {#AppURL}
AppSupportURL = {#AppURL}/contact
AppUpdatesURL = {#AppURL}/patch
DefaultGroupName = {#AppName}
OutputBaseFilename = {#AppFileName}
OutputDir = {#SourcePath}..\out
VersionInfoVersion = {#AppVersion}
VersionInfoDescription = {#Appname} Patch
InfoBeforeFile = {#SourcePath}Instructions.rtf
InfoAfterFile = {#SourcePath}Release Notes.rtf
SetupIconFile = {#SourcePath}logo.ico
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
Name: "patch";        Description: "English patch";    Types: full custom compact; Flags: fixed
Name: "subbedvideos"; Description: "Subbed videos";    Types: full
Name: "{#SubV}mv200"; Description: "mv200";            Types: full 
Name: "{#SubV}mv010"; Description: "mv010";            Types: full
Name: "{#SubV}mv020"; Description: "mv020";            Types: full
Name: "{#SubV}mv070"; Description: "mv070";            Types: full
Name: "{#SubV}mv080"; Description: "mv080";            Types: full
Name: "{#SubV}mv090"; Description: "mv090";            Types: full
Name: "desktopicon";  Description: "Desktop shortcut"; Types: full

[Dirs]
Name: "{app}\IC"; Components: subbedvideos
Name: "{userdocs}\White Album 2 Patch Logs"; 

[Icons]
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Components: desktopicon
    
[Files]
Source: "{#SourcePath}..\bin\WA2_en.exe"; DestDir: "{app}"; Components: patch

;Patch Files
Source: "{tmp}\en.pak";    DestDir: "{app}"; Components: patch; Flags: ignoreversion     {#ExterFlags};
Source: "{tmp}\ev000.pak"; DestDir: "{app}"; Components: patch; Flags: onlyifdoesntexist {#ExterFlags}; ExternalSize:    2707456
Source: "{tmp}\ev150.pak"; DestDir: "{app}"; Components: patch; Flags: onlyifdoesntexist {#ExterFlags}; ExternalSize:  114393088

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
  appIsSet: Boolean;
#ifndef _VAR_
#define _VAR_
  errorCounter: Integer;
  ev000_DL, ev150_DL: Boolean;
#endif

function InitializeSetup(): Boolean;
begin
  try
    appIsSet := False;
  except
    ShowExceptionMessage;
  end;
  try
    errorCounter := 0;
  except
    ShowExceptionMessage;
  end;

  Result := True;
end;
  
function NextButtonClick(CurPageID: Integer): Boolean;
begin
  if CurPageID = wpSelectDir then appIsSet := True;

  if CurPageID = wpReady then begin
    Log('-- Initializing downloads --');
    Log('Downloading en.pak.');
    idpAddFile('https://www.dropbox.com/s/rkl4hwij4mshef2/en.pak?dl=1', ExpandConstant('{tmp}\en.pak'));

    DownloadPatchFile('https://www.dropbox.com/s/kkw5xaxq177yu49/ev000.pak?dl=1', 'ev000',   2707456);
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
    end;
    idpDownloadAfter(wpReady);
    Log('Downloading ' + IntToStr(idpFilesCount) + ' file(s).');
  end;
	
  Result := True;
end;

procedure DeinitializeSetup();
begin
  if appIsSet then begin
    if IsComponentSelected('subbedvideos') then begin
      Log('-- Checking downloads --');     
      if ev000_DL then IsFileDownloaded('ev000.pak', 'ev000.pak');
      if ev150_DL then IsFileDownloaded('ev150.pak', 'ev150.pak');

      if IsComponentSelected('{#SubV}mv200') then IsFileDownloaded('mv200.pak',     'mv200.pak');
      if IsComponentSelected('{#SubV}mv010') then IsFileDownloaded('mv010.pak', '\IC\mv010.pak');
      if IsComponentSelected('{#SubV}mv020') then IsFileDownloaded('mv020.pak', '\IC\mv020.pak');
      if IsComponentSelected('{#SubV}mv070') then IsFileDownloaded('mv070.pak', '\IC\mv070.pak');
      if IsComponentSelected('{#SubV}mv080') then IsFileDownloaded('mv080.pak', '\IC\mv080.pak');
      if IsComponentSelected('{#SubV}mv090') then IsFileDownloaded('mv090.pak', '\IC\mv090.pak'); 
    end;
    Log('Downloads ended with ' + IntToStr(errorCounter) + ' error(s).');

    Log('-- Checking MD5 hashes --');
    LogMD5CC('en.pak', '');
    LogMD5CC('WA2_en.exe', '34a2e8b839b6d19c6efb0488a527a7d4');
    if ev000_DL then LogMD5CC('ev000.pak', '1a66cec0f63148a8baf0458e5c3d4675');
    if ev150_DL then LogMD5CC('ev150.pak', 'de60616ee1641856070e454bea596d83');

    if IsComponentSelected('{#SubV}mv200') then  LogMD5CC('mv200.pak', '2f605315223d7691244189b94b2b13d3');
    if IsComponentSelected('{#SubV}mv010') then  LogMD5IC('mv010.pak', '797623b4fd9e1587a7757333f88e340c');
    if IsComponentSelected('{#SubV}mv020') then  LogMD5IC('mv020.pak', '2195ee1069d1bf2fc7f7fb59109386d8');
    if IsComponentSelected('{#SubV}mv070') then  LogMD5IC('mv070.pak', 'f6c477dfbe1767e0a70554cb40e1e27b');
    if IsComponentSelected('{#SubV}mv080') then  LogMD5IC('mv080.pak', '1890b98d6690f434ab8f7e3fdb37d998');
    if IsComponentSelected('{#SubV}mv090') then  LogMD5IC('mv090.pak', '2e397a50d035e263aa1360062114268a');
  end;
  try
    FileCopy(ExpandConstant('{log}'), ExpandConstant('{userdocs}\White Album 2 Patch Logs\') + \
    ChangeFileExt(ExtractFileName(ExpandConstant('{log}')), '.log'), false);
  except
    ShowExceptionMessage;
  end;
  RestartReplace(ExpandConstant('{log}'), '');
end;
