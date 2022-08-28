#ifndef VERSION
#define VERSION     "1.0.3.0"
#endif

#define BINPATH     SourcePath + "..\bin"
#define EXTERNL     "external skipifsourcedoesntexist"
#define POSTINS     "postinstall skipifsilent"
#define WA2REGK     "Software\Leaf\WHITE ALBUM2"

#define NAME_NVL01  "The Snow Melts and Until It Falls Again"
#define NAME_NVL02  "The Idol Who Forgot How to Sing"

#define STORJ_DDL(str id, str name)  \
    "https://link.storjshare.io/s/" + id + "/wa2/" + name + "?download"

#define LINK_MV010  STORJ_DDL("jxr7fwo6woldze2kqmd7chqpzn3q", "IC/mv010.pak")
#define LINK_MV020  STORJ_DDL("juhelldttg22pfzbs4rpifncmboa", "IC/mv020.pak")
#define LINK_MV070  STORJ_DDL("jvo7rwtjk7kmbjbh3dgg2ryse3ga", "IC/mv070.pak")
#define LINK_MV080  STORJ_DDL("jxqwoyh2jtclvfhnwxrbwzxrwd5q", "IC/mv080.pak")
#define LINK_MV090  STORJ_DDL("jwyavmksnxqjnng24krrij2b2xpa", "IC/mv090.pak")
#define LINK_MV100  STORJ_DDL("jwopg7t73zwnjy7tacji7ey7abea", "mv100.pak")
#define LINK_MV110  STORJ_DDL("jv35b6dmsfid6xlil462tlbzgn6q", "mv110.pak")
#define LINK_MV120  STORJ_DDL("jud7xgogpkopfae47hb6bmo6oppq", "mv120.pak")
#define LINK_MV130  STORJ_DDL("jwupfjoj74kfqliokeahduy4rljq", "mv130.pak")
#define LINK_MV140  STORJ_DDL("jw7eq4uyak53jlw4turqrjvvmipq", "mv140.pak")
#define LINK_MV200  STORJ_DDL("jxal7adnn6irrkgeq5mzsykjdrpa", "mv200.pak")
#define LINK_MV210  STORJ_DDL("jvxqawllvsqbxg6llcjwv5ijjvva", "mv210.pak")
#define LINK_MV220  STORJ_DDL("jvxtugdfpls6vnxle66vgqfwnzoa", "mv220.pak")
#define LINK_MV230  STORJ_DDL("jxppxkby37wcxiuhvtjx3q26az2q", "mv230.pak")
#define LINK_MV240  STORJ_DDL("jx2wpm3cdhaqbkv7ld5zcwh4y2na", "mv240.pak")
#define LINK_D3D9O  STORJ_DDL("jxckpe3fge25e7saetkdloqecitq", "d3d9.dll.old")
#define LINK_D3D9N  STORJ_DDL("jxtudisskdlct52qtsrvbimfvkdq", "d3d9.dll")
#define LINK_STTXT  STORJ_DDL("ju7jkdv6kadxqbdcilgxf6scaroq", "todokanai/subtitles")
#define LINK_STFNT  STORJ_DDL("jwunncmwuh2wophbvjpgn6osw23q", "todokanai/font.png")
#define LINK_NVL01  STORJ_DDL("jvkvsu3yz3y6flgemufmyoiv6odq", "novels/" + NAME_NVL01 + ".pdf")
#define LINK_NVL02  STORJ_DDL("jxpom7l3sxorwtu2bxacavhhtuwa", "novels/" + NAME_NVL02 + ".pdf")

#define HASH_MV010  "a8da9a137751e8f0b4b7288e652ea4dea3eea234cb60fd14f86da99755f6a95e"
#define HASH_MV020  "623c8cd891def54e1e56ea398a3840f674413a65f8d67d6b0deb3dd5c8f0dda2"
#define HASH_MV070  "a30fb48721021fb7a14517b930666bb4a985324cbcb7a31bb4b0eb181de96da3"
#define HASH_MV080  "49c718a8bcd9eb141e0a61f30a17b2029b8e3bdce56c93d43ae74998b5e6060c"
#define HASH_MV090  "e24378f5f7781760e1b6f990667035ad034d186eb8d3ce3da14bda10ef783b4a"
#define HASH_MV100  "89760aa6b405c6ab1781f24ddbd21599bfc60156069b2067d5ee3991073f14b1"
#define HASH_MV110  "bea90e708258fd35ffdb4954963870950aa8f3959551c27c8c37771b02426fad"
#define HASH_MV120  "50991d3aeb0e89cf780aa5ed7bd8971ab2c2f98ca8adcbe42f4866236445b306"
#define HASH_MV130  "7749745d8a437d4f858a3cc1c295c2049c60b97de5057249489c9eb93e0798cb"
#define HASH_MV140  "a7519c4eca8917a73739622838bfcfe0d3849527d55329576d735220bc1fae85"
#define HASH_MV200  "d22fdc10f3938e10d98c3f7608f3b6e18e3042bda4ad7c9be951aa16c273e410"
#define HASH_MV210  "cc36898912b0bbc85dc2c2c748d0dee990f0694f5398b74c1ef14e08bc6d6e7a"
#define HASH_MV220  "a23dacbe57bb2c869fa525ef5e645c49af4e8cc40a4fe003282de9933293b73f"
#define HASH_MV230  "ef571c4c0dc245831815b1aca55ea780300535901516622825da0e0ca2d297d1"
#define HASH_MV240  "bc4865bf16d316acda48334d4317f2fbc797b3f7119842f18a7bf07b960c2551"
#define HASH_D3D9O  "49c098a07cc8fea6be6aea7d1dfd973e83d9b434144b1584591e99e189178b0f"
#define HASH_D3D9N  "cdc8070a3bd64216b37c920a4306735f3da9a68d707bf42f6267dc4def3dbb01"
#define HASH_STTXT  "44b40b444bdd45c943f795cd2c8fdbc59bb35696cac7c79a7bb3e2e6f70220e9"
#define HASH_STFNT  "002b00fae25a6b564e86117e5c2e0ebb21b811ca697c648561aaa86e1a239a92"
#define HASH_NVL01  "1e5ccb135827b2afa359fd1d8346823412e1a20607213a3325c3b27a844ce38e"
#define HASH_NVL02  "500b1fc9ea84ec13671783a3a7179699509c2ed85243241a28b55b676083e5b8"

#define SIZE_MV010  "006282939"
#define SIZE_MV020  "122942110"
#define SIZE_MV070  "008637287"
#define SIZE_MV080  "117288917"
#define SIZE_MV090  "131932557"
#define SIZE_MV100  "057920807"
#define SIZE_MV110  "191787717"
#define SIZE_MV120  "155892736"
#define SIZE_MV130  "149066527"
#define SIZE_MV140  "168492090"
#define SIZE_MV200  "121775605"
#define SIZE_MV210  "118397652"
#define SIZE_MV220  "298456456"
#define SIZE_MV230  "198469312"
#define SIZE_MV240  "073624895"
#define SIZE_D3D9O  "000243712"
#define SIZE_D3D9N  "000263168"
#define SIZE_STTXT  "000025691"
#define SIZE_STFNT  "000065497"
#define SIZE_NVL01  "001253262"
#define SIZE_NVL02  "001085084"

[Setup]
; App info
AppId = {{89357994-3C15-4411-894D-A23CE3FF1AA1}
AppName = White Album 2 English
AppVersion = {#VERSION}
AppPublisher = Todokanai TL
AppCopyright = Copyright (C) 2017-2022, Todokanai TL
AppUpdatesURL = https://github.com/TodokanaiTL/WA2EnglishPatch/releases
AppPublisherURL = https://todokanaitl.github.io
AppSupportURL = https://discord.gg/5rrxEUN
VersionInfoDescription = White Album 2 English Patch
VersionInfoVersion = {#VERSION}

; Output
OutputDir = {#SourcePath}..\out
OutputBaseFilename = WA2_patch

; Included files
LicenseFile = {#SourcePath}..\LICENSE
InfoBeforeFile = {#SourcePath}..\res\Instructions.rtf
InfoAfterFile = {#SourcePath}..\res\ReleaseNotes.rtf
SetupIconFile = {#SourcePath}..\res\logo.ico
WizardImageFile = {#SourcePath}..\res\164x314.bmp
WizardSmallImageFile = {#SourcePath}..\res\55x55.bmp

; Compression
Compression = lzma2/ultra
LZMANumBlockThreads = 4
LZMAUseSeparateProcess = yes

; Installation
DirExistsWarning = no
DefaultDirName = {src}
UsePreviousAppDir = yes
AppendDefaultDirName = no
UsedUserAreasWarning = no
DisableProgramGroupPage = yes
AllowCancelDuringInstall = yes
ArchitecturesAllowed = x86 x64
EnableDirDoesntExistWarning = yes
ArchitecturesInstallIn64BitMode = x64

; Misc
Uninstallable = no
SetupLogging = yes
WizardStyle = modern
TimeStampsInUTC = yes
WizardSizePercent = 135
WizardImageStretch = no
WizardImageAlphaFormat = defined
DefaultDialogFontName = Lucida Sans Unicode

[Languages]
; Setup language
Name: "English"; MessagesFile: "compiler:Default.isl"

[CustomMessages]
; Custom messages
MissingGame=You have to install the original game first!

[Types]
; Installation types
Name: "default"; Description: "Default installation"
Name: "minimal"; Description: "Minimal installation"
Name: "custom";  Description: "Custom installation"; Flags: iscustom

[Components]
; Installation components
Name: "patch";        Description: "English patch";     Types: custom default minimal; Flags: fixed
Name: "subtitles";    Description: "Audio-only subs";   Types: custom default
Name: "videos";       Description: "Subbed videos";     Types: custom
Name: "videos\mv010"; Description: "mv010";             Types: custom default
Name: "videos\mv020"; Description: "mv020";             Types: custom
Name: "videos\mv070"; Description: "mv070";             Types: custom default
Name: "videos\mv080"; Description: "mv080";             Types: custom
Name: "videos\mv090"; Description: "mv090";             Types: custom
Name: "videos\mv100"; Description: "mv100";             Types: custom
Name: "videos\mv110"; Description: "mv110";             Types: custom
Name: "videos\mv120"; Description: "mv120";             Types: custom
Name: "videos\mv130"; Description: "mv130";             Types: custom
Name: "videos\mv140"; Description: "mv140";             Types: custom
Name: "videos\mv200"; Description: "mv200";             Types: custom
Name: "videos\mv210"; Description: "mv210";             Types: custom
Name: "videos\mv220"; Description: "mv220";             Types: custom
Name: "videos\mv230"; Description: "mv230";             Types: custom
Name: "videos\mv240"; Description: "mv240";             Types: custom
Name: "novels";       Description: "Digital novels";    Types: custom

[Dirs]
; Directories
Name: "{app}\IC";        Components: videos
Name: "{app}\novels";    Components: novels
Name: "{app}\todokanai"; Components: subtitles

[Tasks]
; Installation tasks
Name: desktopicon; Description: "Create a &desktop shortcut";    Flags: checkedonce
Name: menuicon;    Description: "Create a &start menu shortcut"; Flags: unchecked

[Icons]
; Shortcuts
Name: "{commondesktop}\White Album 2";  Filename: "{app}\WA2.exe"; Tasks: desktopicon
Name: "{commonprograms}\White Album 2"; Filename: "{app}\WA2.exe"; Tasks: menuicon

[INI]
; Edit SYSTEM.ini
Filename: "{userdocs}\Leaf\WHITE ALBUM2\SYSTEM.ini"; Section: "DEFAULT"; Key: "mov_lv"; String: 2

[Run]
; Postinstall options
Filename: "{app}\WA2.exe";    Description: "Launch game";        Flags: {#POSTINS} nowait
Filename: "{app}\novels";     Description: "Open novels folder"; Flags: {#POSTINS} unchecked shellexec; Components: novels
Filename: "{log}";            Description: "Open log file";      Flags: {#POSTINS} unchecked shellexec

[Files]
; Rename originals
Source: "{app}\WA2.exe";           DestDir: "{app}";           DestName: WA2.exe.BKP;    Flags: external onlyifdoesntexist
Source: "{app}\mv000.pak";         DestDir: "{app}";           DestName: mv000.pak.BKP;  Flags: external onlyifdoesntexist

; Patch files
Source: "{#BINPATH}\en.pak";       DestDir: "{app}";           Components: patch;        Flags: overwritereadonly setntfscompression
Source: "{#BINPATH}\WA2.exe";      DestDir: "{app}";           Components: patch;        Flags: overwritereadonly
Source: "{#BINPATH}\mv000.pak";    DestDir: "{app}";           Components: patch;        Flags: overwritereadonly

; Subtitles
Source: "{tmp}\d3d9.dll";          DestDir: "{app}";           Components: subtitles;    Flags: {#EXTERNL}; ExternalSize: {#SIZE_D3D9N}
Source: "{tmp}\font.png";          DestDir: "{app}\todokanai"; Components: subtitles;    Flags: {#EXTERNL}; ExternalSize: {#SIZE_STFNT}
Source: "{tmp}\subtitles";         DestDir: "{app}\todokanai"; Components: subtitles;    Flags: {#EXTERNL}; ExternalSize: {#SIZE_STTXT}

; Extra videos
Source: "{tmp}\mv010.pak";         DestDir: "{app}\IC";        Components: videos\mv010; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV010}
Source: "{tmp}\mv020.pak";         DestDir: "{app}\IC";        Components: videos\mv020; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV020}
Source: "{tmp}\mv070.pak";         DestDir: "{app}\IC";        Components: videos\mv070; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV070}
Source: "{tmp}\mv080.pak";         DestDir: "{app}\IC";        Components: videos\mv080; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV080}
Source: "{tmp}\mv090.pak";         DestDir: "{app}\IC";        Components: videos\mv090; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV090}
Source: "{tmp}\mv100.pak";         DestDir: "{app}";           Components: videos\mv100; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV100}
Source: "{tmp}\mv110.pak";         DestDir: "{app}";           Components: videos\mv110; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV110}
Source: "{tmp}\mv120.pak";         DestDir: "{app}";           Components: videos\mv120; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV120}
Source: "{tmp}\mv130.pak";         DestDir: "{app}";           Components: videos\mv130; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV130}
Source: "{tmp}\mv140.pak";         DestDir: "{app}";           Components: videos\mv140; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV140}
Source: "{tmp}\mv200.pak";         DestDir: "{app}";           Components: videos\mv200; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV200}
Source: "{tmp}\mv210.pak";         DestDir: "{app}";           Components: videos\mv210; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV210}
Source: "{tmp}\mv220.pak";         DestDir: "{app}";           Components: videos\mv220; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV220}
Source: "{tmp}\mv230.pak";         DestDir: "{app}";           Components: videos\mv230; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV230}
Source: "{tmp}\mv240.pak";         DestDir: "{app}";           Components: videos\mv240; Flags: {#EXTERNL}; ExternalSize: {#SIZE_MV240}

; Novels
Source: "{tmp}\{#NAME_NVL01}.pdf"; Destdir: "{app}\novels";    Components: novels;       Flags: {#EXTERNL}; ExternalSize: {#SIZE_NVL01}
Source: "{tmp}\{#NAME_NVL02}.pdf"; Destdir: "{app}\novels";    Components: novels;       Flags: {#EXTERNL}; ExternalSize: {#SIZE_NVL02}

[Code]
var
  DLPage:  TDownloadWizardPage;
  folder:  String;

{* Get the installation folder of the game *}
function GetInstallDir(var value: String): Boolean;
begin
  Result := RegQueryStringValue(HKLM, '{#WA2REGK}', 'InstallDir', value)
         or RegQueryStringValue(HKCU, '{#WA2REGK}', 'InstallDir', value);
end;

{* Prepare component file download *}
function PrepareDL(const dest, name, cmpn: String): Boolean;
var
  path: String;
begin
  Result := WizardIsComponentSelected(cmpn);
  if not Result then Exit;
  path := ExpandConstant(dest + name);
  if FileExists(path) and not FileExists(path + '.BKP') then begin
    Result := RenameFile(path, path + '.BKP');
    if Result then Log('Created backup for '  + name + '.')
    else Log('Failed to create backup for ' + name + '.');
  end else begin
    Result := not FileExists(path);
  end;
end;

procedure InitializeWizard();
begin
  if GetInstallDir(folder) then
    WizardForm.DirEdit.Text := folder;

  WizardForm.LicenseAcceptedRadio.Checked := True;

  DLPage := CreateDownloadPage(SetupMessage(msgWizardPreparing),
                               SetupMessage(msgPreparingDesc), nil);
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = wpSelectDir then begin
    Result := FileExists(ExpandConstant('{app}\WA2.exe'))
    if not Result then
      MsgBox(ExpandConstant('{cm:MissingGame}'), mbCriticalError, MB_OK);
  end else if CurPageID = wpReady then begin
    if not WizardIsComponentSelected('subtitles') and
       not WizardIsComponentSelected('videos') and
       not WizardIsComponentSelected('novels') then Exit;
    Log('-- Downloading files --');
    DLPage.Clear;

    if WizardIsComponentSelected('subtitles') then begin
      if RegKeyExists(HKCU, 'Software\Wine') then begin
        DLPage.Add('{#LINK_D3D9O}', 'd3d9.dll', '{#HASH_D3D9O}');
      end else begin
        DLPage.Add('{#LINK_D3D9N}', 'd3d9.dll', '{#HASH_D3D9N}');
      end;
      DLPage.Add('{#LINK_STFNT}', 'font.png', '{#HASH_STFNT}');
      DLPage.Add('{#LINK_STTXT}', 'subtitles', '{#HASH_STTXT}');
    end else begin
      Log('Subtitles were not selected.')
    end;

    if WizardIsComponentSelected('videos') then begin
      if PrepareDL('{app}\IC\', 'mv010.pak', 'videos\mv010') then
        DLPage.Add('{#LINK_MV010}', 'mv010.pak', '{#HASH_MV010}');
      if PrepareDL('{app}\IC\', 'mv020.pak', 'videos\mv020') then
        DLPage.Add('{#LINK_MV020}', 'mv020.pak', '{#HASH_MV020}');
      if PrepareDL('{app}\IC\', 'mv070.pak', 'videos\mv070') then
        DLPage.Add('{#LINK_MV070}', 'mv070.pak', '{#HASH_MV070}');
      if PrepareDL('{app}\IC\', 'mv080.pak', 'videos\mv080') then
        DLPage.Add('{#LINK_MV080}', 'mv080.pak', '{#HASH_MV080}');
      if PrepareDL('{app}\IC\', 'mv090.pak', 'videos\mv090') then
        DLPage.Add('{#LINK_MV090}', 'mv090.pak', '{#HASH_MV090}');
      if PrepareDL('{app}\', 'mv100.pak', 'videos\mv100') then
        DLPage.Add('{#LINK_MV100}', 'mv100.pak', '{#HASH_MV100}');
      if PrepareDL('{app}\', 'mv110.pak', 'videos\mv110') then
        DLPage.Add('{#LINK_MV110}', 'mv110.pak', '{#HASH_MV110}');
      if PrepareDL('{app}\', 'mv120.pak', 'videos\mv120') then
        DLPage.Add('{#LINK_MV120}', 'mv120.pak', '{#HASH_MV120}');
      if PrepareDL('{app}\', 'mv130.pak', 'videos\mv130') then
        DLPage.Add('{#LINK_MV130}', 'mv130.pak', '{#HASH_MV130}');
      if PrepareDL('{app}\', 'mv140.pak', 'videos\mv140') then
        DLPage.Add('{#LINK_MV140}', 'mv140.pak', '{#HASH_MV140}');
      if PrepareDL('{app}\', 'mv200.pak', 'videos\mv200') then
        DLPage.Add('{#LINK_MV200}', 'mv200.pak', '{#HASH_MV200}');
      if PrepareDL('{app}\', 'mv210.pak', 'videos\mv210') then
        DLPage.Add('{#LINK_MV210}', 'mv210.pak', '{#HASH_MV210}');
      if PrepareDL('{app}\', 'mv220.pak', 'videos\mv220') then
        DLPage.Add('{#LINK_MV220}', 'mv220.pak', '{#HASH_MV220}');
      if PrepareDL('{app}\', 'mv230.pak', 'videos\mv230') then
        DLPage.Add('{#LINK_MV230}', 'mv230.pak', '{#HASH_MV230}');
      if PrepareDL('{app}\', 'mv240.pak', 'videos\mv240') then
        DLPage.Add('{#LINK_MV240}', 'mv240.pak', '{#HASH_MV240}');
    end else begin
      Log('No videos were selected.');
    end;

    if WizardIsComponentSelected('novels') then begin
      DLPage.Add('{#LINK_NVL01}', '{#NAME_NVL01}.pdf', '{#HASH_NVL01}');
      DLPage.Add('{#LINK_NVL02}', '{#NAME_NVL02}.pdf', '{#HASH_NVL02}');
    end else begin
      Log('Novels were not selected.')
    end;

    DLPage.Show;
    try
      DLPage.Download;
    except
      Result := False;
      MsgBox(GetExceptionMessage, mbCriticalError, MB_OK);
    finally
      DLPage.Hide;
    end;
  end;
end;
