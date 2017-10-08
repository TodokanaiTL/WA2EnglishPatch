#include <idp.iss>
#include "WA2_functions.iss"

#define AppName "White Album 2 English"
#define AppVersion "0.8.3.0"
#define AppPublisher "Todokanai TL"
#define AppURL "https://todokanaitl.wordpress.com"
#define AppExeName "WA2_en.exe"
#define AppFileName "WA2_patch"

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
OutputDir = {#SourcePath}..\bin
OutputManifestFile = ..\WA2_Patch_{#AppVersion}.manifest
VersionInfoVersion = {#AppVersion}
VersionInfoDescription = {#Appname} Patch
InfoBeforeFile = {#SourcePath}Instructions.rtf
InfoAfterFile = {#SourcePath}Release Notes.rtf
SetupIconFile = {#SourcePath}logo.ico
PrivilegesRequired = admin 
;Compression = zip/9
Compression = lzma2/ultra
LZMAUseSeparateProcess = yes
LZMADictionarySize = 524288  
LZMANumFastBytes = 273
SolidCompression = yes
DefaultDirName = {src}
UsePreviousAppDir = yes
AppendDefaultDirName = no
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
Name: "patch";              Description: "English patch";    Types: full custom compact; Flags: fixed
Name: "subbedvideos";       Description: "Subbed videos";    Types: full
Name: "subbedvideos\mv200"; Description: "mv200";            Types: full 
Name: "subbedvideos\mv010"; Description: "mv010";            Types: full
Name: "subbedvideos\mv020"; Description: "mv020";            Types: full
Name: "subbedvideos\mv070"; Description: "mv070";            Types: full
Name: "subbedvideos\mv080"; Description: "mv080";            Types: full
Name: "subbedvideos\mv090"; Description: "mv090";            Types: full
Name: "desktopicon";        Description: "Desktop shortcut"; Types: full

[Dirs]
Name: "{app}\IC"; Components: subbedvideos
Name: "{userdocs}\White Album 2 Patch Logs"; 

[Icons]
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; Components: desktopicon
    
[Files]
Source: "{#SourcePath}..\patch\WA2_en.exe"; DestDir: "{app}"; Components: patch
;https://www.dropbox.com/s/aj7yjlqv5i41x16/WA2_en.exe?dl=0
Source: "{#SourcePath}..\patch\en.pak";     DestDir: "{app}"; Components: patch; Flags: ignoreversion
;https://www.dropbox.com/s/rkl4hwij4mshef2/en.pak?dl=0
Source: "{#SourcePath}..\patch\ev000.pak";  DestDir: "{app}"; Components: patch; Flags: onlyifdoesntexist
;https://www.dropbox.com/s/kkw5xaxq177yu49/ev000.pak?dl=0
Source: "{#SourcePath}..\patch\ev150.pak";  DestDir: "{app}"; Components: patch; Flags: onlyifdoesntexist
;https://www.dropbox.com/s/9mcw7evymo6sbx0/ev150.pak?dl=0

;Videos CC
Source: "{tmp}\mv200.pak"; DestDir: "{app}";    Components: subbedvideos\mv200; Flags: external skipifsourcedoesntexist; ExternalSize: 189390848 

;Videos IC
Source: "{tmp}\mv010.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv010; Flags: external skipifsourcedoesntexist; ExternalSize: 014159872
Source: "{tmp}\mv020.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv020; Flags: external skipifsourcedoesntexist; ExternalSize: 215715840 
Source: "{tmp}\mv070.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv070; Flags: external skipifsourcedoesntexist; ExternalSize: 014618624 
Source: "{tmp}\mv080.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv080; Flags: external skipifsourcedoesntexist; ExternalSize: 189677568 
Source: "{tmp}\mv090.pak"; DestDir: "{app}\IC"; Components: subbedvideos\mv090; Flags: external skipifsourcedoesntexist; ExternalSize: 230576128 

[Code]

var
  #ifndef ERRC
  #define ERRC
  ErrorCounter: Integer;
  #endif
  DateTimeString: String;


function NextButtonClick(CurPageID: Integer): Boolean;
begin       
  if CurPageID = wpReady then begin
    if IsComponentSelected('subbedvideos') then begin

      ErrorCounter := 0;
      Log('-- Initializing downloads --');

      {* Closing Chapter *}
      {* mv200 *}
      DownloadFileCC('https://www.dropbox.com/s/stoszrny6akbrhz/ev200.pak?dl=1', 'mv200', 189390848);

      {* Introductory Chapter *}
      {* mv010 *}
      DownloadFileIC('https://www.dropbox.com/s/768bz4ohx3otik7/ev010.pak?dl=1', 'mv010', 014159872);

      {* mv020 *}
      DownloadFileIC('https://www.dropbox.com/s/9kcjcicodjtd7gj/ev020.pak?dl=1', 'mv020', 215715840);

      {* mv070 *}
      DownloadFileIC('https://www.dropbox.com/s/co5upv8f1ocw7m3/ev070.pak?dl=1', 'mv070', 014618624);
		
      {* mv080 *}
      DownloadFileIC('https://www.dropbox.com/s/hn57kfgrpzqbpoa/ev080.pak?dl=1', 'mv080', 189677568);
		
      {* mv090 *}
      DownloadFileIC('https://www.dropbox.com/s/012laiv3ycm2quk/ev090.pak?dl=1', 'mv090', 230576128);

      idpDownloadAfter(wpReady);
      Log('Downloading ' + IntToStr(idpFilesCount) + ' file(s).');
	  end;
	end;
	
  Result := True;
end;

procedure DeinitializeSetup();
begin
  if IsComponentSelected('subbedvideos') then begin
      
    Log('-- Checking downloads --');
    if not idpFilesDownloaded then Log('Some selected files were not downloaded.');
    IsFileDownloaded('mv200',     'mv200');
    IsFileDownloaded('mv010', '\IC\mv010');
    IsFileDownloaded('mv020', '\IC\mv020');
    IsFileDownloaded('mv070', '\IC\mv070');
    IsFileDownloaded('mv080', '\IC\mv080');
    IsFileDownloaded('mv090', '\IC\mv090'); 
  end;
  Log('Setup ended with ' + IntToStr(ErrorCounter) + ' error(s).');
  FileCopy(ExpandConstant('{log}'), ExpandConstant('{userdocs}\White Album 2 Patch Logs\') + ChangeFileExt(ExtractFileName(ExpandConstant('{log}')), '.log'), false);
end; 
