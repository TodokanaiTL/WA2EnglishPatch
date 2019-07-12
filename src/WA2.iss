#include <idp.iss>
#include "WA2_functions.iss"

#ifndef VERSION
#define VERSION     "0.9.0.1"
#endif

#define EXEFILE     SourcePath + "..\bin\WA2_en.exe"
#define WA2DOCS     "{userdocs}\Leaf\WHITE ALBUM2"
#define LOGDIR      "{userdocs}\White Album 2 Patch Logs\"
#define EXTER       "external skipifsourcedoesntexist"
#define POSTINS     "postinstall skipifsilent"

#define MD5_WA2     GetMD5OfFile(EXEFILE)
#define MD5_EV000   "1a66cec0f63148a8baf0458e5c3d4675"
#define MD5_EV150   "ed4978b7f10ea70bf0ee1315a87be4a1"
#define MD5_MV010   "797623b4fd9e1587a7757333f88e340c"
#define MD5_MV020   "2195ee1069d1bf2fc7f7fb59109386d8"
#define MD5_MV070   "f6c477dfbe1767e0a70554cb40e1e27b"
#define MD5_MV080   "1890b98d6690f434ab8f7e3fdb37d998"
#define MD5_MV090   "2e397a50d035e263aa1360062114268a"
#define MD5_MV200   "2f605315223d7691244189b94b2b13d3"

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
AppCopyright = Copyright (C) 2017, Todokanai TL
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
InfoBeforeFile = {#SourcePath}..\docs\Instructions.rtf
InfoAfterFile = {#SourcePath}..\docs\Release Notes.rtf
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
Name: "{#LOGDIR}"

[Icons]
; Desktop shortcut
Name: "{commondesktop}\White Album 2"; Filename: "{app}\WA2_en.exe"; Components: desktopicon

[INI]
; Edit SYSTEM.ini
Filename: "{#WA2DOCS}\SYSTEM.ini"; Section: "DEFAULT"; Key: "mov_lv"; String: 2

[Run]
; Postinstall options
Filename: "{#LOGDIR}";        Description: Open log folder; Flags: {#POSTINS} unchecked shellexec
Filename: "{app}\WA2_en.exe"; Description: Launch game;     Flags: {#POSTINS} nowait

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
const
  FILENUM = 8;
var
  appIsSet:      Boolean;
  wasCancelled:  Boolean;
  dateTime:      String;
  downloaded:    TArrayOfString;
  destDir:       TArrayOfString;
  md5Sums:       TArrayOfString;
  fileSizes:     TArrayOfString;
  fileNames:     TArrayOfString;
  urlHashes:     TArrayOfString;
  index:         Integer;
  err:           String;
  size:          Integer;

function InitializeSetup(): Boolean;
begin
  try
    dateTime := GetDateTimeString('yyyy-mm-dd_hh.nn.ss', '-', '.');
  except
    ShowExceptionMessage;
  end;

  appIsSet := False;
  wasCancelled := False;

#ifndef IS_DMM
  if not (IsWine() or IsInstalled()) then begin
    err := 'You have to install the original game before applying the patch!';
    MsgBox(err, mbCriticalError, MB_OK);
    Result := False;
    ExitProcess(3);
  end;
#endif
  Result := True;
end;

procedure InitializeWizard();
begin
  WizardForm.LicenseAcceptedRadio.Checked := True;
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  wasCancelled := Confirm;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpSelectDir then appIsSet := True;

  if CurPageID = wpReady then begin
    {* Initialise arrays *}
    SetArrayLength(downloaded, FILENUM);
    SetArrayLength(destDir, FILENUM);
    SetArrayLength(md5Sums, FILENUM);
    SetArrayLength(fileSizes, FILENUM);
    SetArrayLength(fileNames, FILENUM);
    SetArrayLength(urlHashes, FILENUM);
    try
      for index := 0 to (GetArrayLength(destDir) - 1) do begin
        downloaded[index] := 'no';
        destDir[index] := '{app}\';
      end;
      md5Sums := Split(' ', \
        '{#MD5_EV000} {#MD5_EV150} {#MD5_MV010} \
         {#MD5_MV020} {#MD5_MV070} {#MD5_MV080} \
         {#MD5_MV090} {#MD5_MV200}');
      fileSizes := Split(' ', \
        '{#SIZE_EV000} {#SIZE_EV150} {#SIZE_MV010} \
         {#SIZE_MV020} {#SIZE_MV070} {#SIZE_MV080} \
         {#SIZE_MV090} {#SIZE_MV200}');
      fileNames := Split(' ', \
        'ev000.pak ev150.pak mv010.pak mv020.pak \
         mv070.pak mv080.pak mv090.pak mv200.pak');
      urlHashes := Split(' ', \
        'GSJAI3ImXkKyhTU ytHgR2d9smdEobF sRAzdd4ccW7lTok \
         3ogQTfqSrShs92j FTF5wxZXOlPdEQx SvvMcAjsTSy9z1H \
         b7DlHjPRgro8wyp kDDSTHYUEi6wRP2');
    except
      ShowExceptionMessage;
    end;

    Log('-- Initialising downloads --');
    idpSetOption('RetryButton',    '0');
    idpSetOption('DetailedMode',   '1');
    idpSetOption('AllowContinue',  '1');
    idpSetOption('ErrorDialog',    'FileList');
    idpSetOption('UserAgent',      'WA2EN/{#VERSION}');

    Log('Downloading en.pak.');
    idpAddFile('https://www.dropbox.com/s/rkl4hwij4mshef2/en.pak?dl=1', \
               ExpandConstant('{tmp}\en.pak'));

    {* Download patch files *}
    for index := 0 to 1 do begin
      if DownloadPatchFile(DisrootURL(urlHashes[index]), \
                           fileNames[index], \
                           StrToInt(fileSizes[index]), \
                           destDir[index], md5Sums[index])
      then downloaded[index] := fileNames[index];
    end;

    {* Download selected videos *}
    if WizardIsComponentSelected('videos') then begin
      for index := 2 to (FILENUM - 1) do begin
        if index < 7 then destDir[index] := '{app}\IC\';
        if DownloadCompFile(DisrootURL(urlHashes[index]), \
                            fileNames[index], \
                            StrToInt(fileSizes[index]), \
                            destDir[index], md5Sums[index], \
                            'videos/' + Copy(fileNames[index], 1, 5))
        then downloaded[index] := fileNames[index];
      end
    end else begin
      Log('No videos have been selected.');
    end;

    Log('Downloading ' + IntToStr(idpFilesCount) + ' file(s).');
    idpDownloadAfter(wpReady);
  end;

  if CurPageID = wpFinished then begin
    Log('-- Verifying files --');
    LogFileMD5('{app}\en.pak', '');
    LogFileMD5('{app}\WA2_en.exe', '{#MD5_WA2}');
    for index := 0 to (FILENUM - 1) do begin
      if not (downloaded[index] = 'no') then begin
        FileSize(ExpandConstant(destDir[index] + fileNames[index]), size);
        if not (size = StrToInt(fileSizes[index])) then begin
          err := ExtractFileName(fileNames[index]) + \
                 ' appears to be corrupt. Delete it and' + \
                 ' run the installer again to redownload it.';
          MsgBox(err, mbError, MB_OK);
        end;
      end;
    end;
  end;
end;

procedure DeinitializeSetup();
begin
  RestartReplace(ExpandConstant('{log}'), '');
  if not appIsSet then Exit;
  if not wasCancelled then Log('Setup completed.');
  FileCopy(ExpandConstant('{log}'), ExpandConstant('{#LOGDIR}') + \
           'WA2_Patch_Log_' + dateTime + '.log', False);
end;
