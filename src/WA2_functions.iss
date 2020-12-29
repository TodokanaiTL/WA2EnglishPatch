#define REGKEY  "Software\Leaf\WHITE ALBUM2"

[Code]
{* Prepare component file download *}
function PrepareDownload(dest, name, compnt: String): Boolean;
var
  file_: String;
begin
  Result := False
  if not WizardIsComponentSelected(compnt) then Exit;
  file_ := ExpandConstant(dest + name);
  if FileExists(file_) then begin
    if FileExists(file_ + '.BKP') then Exit;
    if RenameFile(file_, file_ + '.BKP') then begin
        Log('Created backup for ' + name + '.');
    end else begin
        Log('Failed to create backup for ' + name + '.');
        Exit;
    end;
  end;
  Result := True;
end;

{* Check if key exists in the registry *}
function CheckRegistry(key: String): Boolean;
begin
  Result := RegKeyExists(HKCU, key) or RegKeyExists(HKLM, key);
end;

{* Get the installation folder of the game *}
function GetInstallDir(var value: String): Boolean;
begin
  Result := RegQueryStringValue(HKCU, '{#REGKEY}', 'InstallDir', value) \
         or RegQueryStringValue(HKLM, '{#REGKEY}', 'InstallDir', value);
end;

{* Check the registry for WA2 *}
function IsInstalled(): Boolean;
begin
  Result := CheckRegistry('{#REGKEY}');
end;

procedure ExitProcess(uExitCode: Integer);
  external 'ExitProcess@kernel32.dll stdcall';
