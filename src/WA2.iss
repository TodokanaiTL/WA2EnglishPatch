#include <idp.iss>
#include "WA2_functions.iss"

#define VERSION     "0.8.6.0"
#define LOGDIR      "{userdocs}\White Album 2 Patch Logs"
#define EXTER       "external skipifsourcedoesntexist"
#define POSTINS     "postinstall skipifsilent"

#define MD5_WA2     "795748323bbc77fdb88b3bc9a2929477"
#define MD5_EV000   "1a66cec0f63148a8baf0458e5c3d4675"
#define MD5_EV150   "de60616ee1641856070e454bea596d83"
#define MD5_MV010   "797623b4fd9e1587a7757333f88e340c"
#define MD5_MV020   "2195ee1069d1bf2fc7f7fb59109386d8"
#define MD5_MV070   "f6c477dfbe1767e0a70554cb40e1e27b"
#define MD5_MV080   "1890b98d6690f434ab8f7e3fdb37d998"
#define MD5_MV090   "2e397a50d035e263aa1360062114268a"
#define MD5_MV200   "2f605315223d7691244189b94b2b13d3"

#define SIZE_EV000  "002707456"
#define SIZE_EV150  "114393088"
#define SIZE_MV010  "014159872"
#define SIZE_MV020  "215715840"
#define SIZE_MV070  "014618624"
#define SIZE_MV080  "189677568"
#define SIZE_MV090  "230576128"
#define SIZE_MV200  "189390848"

[Setup]
; App info
AppId = {{89357994-3C15-4411-894D-A23CE3FF1AA1}
AppName = White Album 2 English
AppVersion = {#VERSION}
AppPublisher = Todokanai TL
AppCopyright = Copyright (C) 2017, Todokanai TL
AppPublisherURL = https://todokanaitl.wordpress.com
AppSupportURL = https://discord.me/TodokanaiTL
VersionInfoVersion = {#VERSION}
VersionInfoDescription = White Album 2 English Patch

; Output
OutputDir = {#SourcePath}..\out
OutputBaseFilename = WA2_patch

; Included files
LicenseFile = {#SourcePath}..\LICENSE
InfoBeforeFile = {#SourcePath}..\docs\Instructions.rtf
InfoAfterFile = {#SourcePath}..\docs\Release Notes.rtf
SetupIconFile = {#SourcePath}..\res\logo.ico

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

[Run]
; Postinstall options
Filename: "{#LOGDIR}";        Description: Open log folder; Flags: {#POSTINS} unchecked shellexec
Filename: "{app}\WA2_en.exe"; Description: Launch game;     Flags: {#POSTINS} nowait

[Files]
; Executable
Source: "{#SourcePath}..\bin\WA2_en.exe"; DestDir: "{app}"; Components: patch

; Patch files
Source: "{tmp}\en.pak";    DestDir: "{app}"; Components: patch; Flags: {#EXTER} ignoreversion;
Source: "{tmp}\ev000.pak"; DestDir: "{app}"; Components: patch; Flags: {#EXTER}; ExternalSize:  {#SIZE_EV000}
Source: "{tmp}\ev150.pak"; DestDir: "{app}"; Components: patch; Flags: {#EXTER}; ExternalSize:  {#SIZE_EV150}

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
  index:         Integer;

function InitializeSetup(): Boolean;
begin
  try
    dateTime := GetDateTimeString('yyyy-mm-dd_hh.nn.ss', '-', '.');
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
    {* Initialise arrays *}
    SetArrayLength(downloaded, FILENUM);
    SetArrayLength(md5Sums, FILENUM);
    SetArrayLength(destDir, FILENUM);
    try
      for index := 0 to (GetArrayLength(destDir) - 1) do
      begin
        downloaded[index] := 'no';
        destDir[index] := '{app}\';
      end
      md5Sums := Split( ' ', \
        '{#MD5_EV000} {#MD5_EV150} {#MD5_MV010} \
         {#MD5_MV020} {#MD5_MV070} {#MD5_MV080} \
         {#MD5_MV090} {#MD5_MV200}' )
    except
      ShowExceptionMessage;
    end

    Log('-- Initialising downloads --');
    idpSetOption('RetryButton',    '0');
    idpSetOption('DetailedMode',   '1');
    idpSetOption('AllowContinue',  '1');
    idpSetOption('ErrorDialog',    'FileList');
    idpSetOption('UserAgent',      'WA2EN/{#VERSION}');

    Log('Downloading en.pak.');
    idpAddFile('https://www.dropbox.com/s/rkl4hwij4mshef2/en.pak?dl=1', ExpandConstant('{tmp}\en.pak'));

    {* Download selected patch files *}
    if DownloadPatchFile('https://cloud.disroot.org/s/GSJAI3ImXkKyhTU/download', \
                         'ev000.pak', {#SIZE_EV000}, destDir[0])
    then downloaded[0] := 'ev000.pak';
    if DownloadPatchFile('https://cloud.disroot.org/s/tB0sd3IXMdKGW0H/download', \
                         'ev150.pak', {#SIZE_EV150}, destDir[1])
    then downloaded[1] := 'ev150.pak';

    {* Download selected videos *}
    if IsComponentSelected('videos') then begin
      {* Introductory Chapter *}
      for index := 2 to 6 do
        destDir[index] := '{app}\IC\';

      {* mv010 *}
      if DownloadCompFile('https://cloud.disroot.org/s/sRAzdd4ccW7lTok/download', \
                          'mv010.pak', {#SIZE_MV010}, destDir[2], 'videos/mv010')
      then downloaded[2] := 'mv010.pak';
      {* mv020 *}
      if DownloadCompFile('https://cloud.disroot.org/s/3ogQTfqSrShs92j/download', \
                          'mv020.pak', {#SIZE_MV020}, destDir[3], 'videos/mv020')
      then downloaded[3] := 'mv020.pak';
      {* mv070 *}
      if DownloadCompFile('https://cloud.disroot.org/s/FTF5wxZXOlPdEQx/download', \
                          'mv070.pak', {#SIZE_MV070}, destDir[4], 'videos/mv070')
      then downloaded[4] := 'mv070.pak';
      {* mv080 *}
      if DownloadCompFile('https://cloud.disroot.org/s/SvvMcAjsTSy9z1H/download', \
                          'mv080.pak', {#SIZE_MV080}, destDir[5], 'videos/mv080')
      then downloaded[5] := 'mv080.pak';
      {* mv090 *}
      if DownloadCompFile('https://cloud.disroot.org/s/b7DlHjPRgro8wyp/download', \
                          'mv090.pak', {#SIZE_MV090}, destDir[6], 'videos/mv090')
      then downloaded[6] := 'mv090.pak';

      {* Closing Chapter *}

      {* mv200 *}
      if DownloadCompFile('https://cloud.disroot.org/s/kDDSTHYUEi6wRP2/download', \
                          'mv200.pak', {#SIZE_MV200}, destDir[7], 'videos/mv200')
      then downloaded[7] := 'mv200.pak';
    end else begin
      Log('No videos have been selected.');
    end;

    Log('Downloading ' + IntToStr(idpFilesCount) + ' file(s).');
    idpDownloadAfter(wpReady);
  end;

  if CurPageID = wpFinished then begin
    Log('-- Verifying MD5 hashes --');
    LogFileMD5('en.pak', '', '{app}\');
    LogFileMD5('WA2_en.exe', '{#MD5_WA2}', '{app}\');
    for index := 0 to (FILENUM - 1) do
      if not (downloaded[index] = 'no') then LogFileMD5(downloaded[index], md5Sums[index], destDir[index]);
  end;
end;

procedure DeinitializeSetup();
begin
  if appIsSet and not wasCancelled then Log('Setup completed.');
  FileCopy(ExpandConstant('{log}'), ExpandConstant('{#LOGDIR}') + 'WA2_Patch_Log_' + dateTime + '.log', False);
  RestartReplace(ExpandConstant('{log}'), '');
end;

{* End *}

