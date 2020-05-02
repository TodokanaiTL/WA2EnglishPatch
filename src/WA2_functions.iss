#define REGKEY "Software\Leaf\WHITE ALBUM2"

[Code]
{* Verify file MD5 *}
function VerifyMD5(name: String; expectedMD5: String): Boolean;
var
  fileMD5: String;
begin
  try
    fileMD5 := GetMD5OfFile(ExpandConstant(name));
  except
    ShowExceptionMessage;
  end;
  Result := (fileMD5 = expectedMD5);
end;

{* Download necessary patch files *}
function DownloadPatchFile(url: String; name: String; size: Integer; \
                           dest: String; md5: String): Boolean;
begin
  if FileExists(ExpandConstant(dest + name))
  and VerifyMD5(dest + name, md5) then begin
    Log(name + ' already exists.');
    Result := False;
    Exit;
  end;
  Log('Downloading ' + name);
  idpAddFileSize(url, ExpandConstant('{tmp}\' + name), size);
  Result := True;
end;

{* Download component files and make backups *}
function DownloadCompFile(url: String; name: String; size: Integer; \
                          dest: String; md5: String; compnt: String): Boolean;
begin
  Result := True;
  if not WizardIsComponentSelected(compnt) then begin
    Log(name + ' has not been selected.');
    Result := False;
    Exit;
  end;
  Log(name + ' has been selected.');
  if FileExists(ExpandConstant(dest + name)) then begin
    if VerifyMD5(dest + name, md5) then begin
      Log(name + ' already exists.');
      Result := False;
      Exit;
    end;
    if RenameFile(ExpandConstant(dest + name), \
                  ExpandConstant(dest + name + '.BKP'))
    then Log('Successfully created BKP file.')
    else Log('Error. Failed to create BKP file.');
  end;
  Log('Downloading ' + name);
  idpAddFileSizeComp(url, ExpandConstant('{tmp}\' + name), size, name);
end;

{* Log MD5 checksum of downloaded files *}
procedure LogFileMD5(name: String; expectedMD5: String);
var
  fileMD5: String;
  baseName: String;
  err: String;
begin
  if FileExists(ExpandConstant(name)) then begin
    try
      baseName := ExtractFileName(name);
      fileMD5 := GetMD5OfFile(ExpandConstant(name));
    except
       ShowExceptionMessage;
    end;
    Log('MD5 hash of ' + baseName + \
        ': ' + Uppercase(fileMD5) + '.');
    if (baseName = 'en.pak') then begin
      Log('File hash cannot be verified automatically.' + \
          ' (This is not an error.)');
    end else begin
      if (fileMD5 = expectedMD5) then begin
        Log('File hash matches expected hash.');
      end else begin
        Log('Error. Expected: ' + Uppercase(expectedMD5) + '.');
        err := baseName + ' appears to be corrupt. Delete it' + \
               ' and run the installer again to redownload it.';
        MsgBox(err, mbError, MB_OK);
      end;
    end;
  end else begin
    Log('Error. ' + baseName + ' could not be found.');
    err := 'Failed to download ' + baseName + \
           '. Run the installer again to redownload it.';
    MsgBox(err, mbError, MB_OK);
  end;
end;

{* Get file URL on Disroot by its hash *}
function DisrootURL(hash: String): String;
begin
  Result := 'https://cloud.disroot.org/s/' + hash + '/download';
end;

{* Check if key exists in the registry *}
function CheckRegistry(key: String): Boolean;
begin
  if IsWin64 then Result := RegKeyExists(HKLM64, key)
  else Result := RegKeyExists(HKLM32, key);
  Result := (Result or RegKeyExists(HKCU, key));
end;

{* Get the installation folder of the game *}
function GetInstallDir(var value: String): Boolean;
begin
    Result := RegQueryStringValue(HKCU, \
        '{#REGKEY}', 'InstallDir', value);
    if not Result then begin
        if IsWin64 then
            Result := RegQueryStringValue(HKLM64, \
                '{#REGKEY}', 'InstallDir', value)
        else
            Result := RegQueryStringValue(HKLM32, \
                '{#REGKEY}', 'InstallDir', value);
    end;
end;

{* Check the registry for WA2 *}
function IsInstalled(): Boolean;
begin
  Result := CheckRegistry('{#REGKEY}');
end;

{* Split string into array *}
{* https://stackoverflow.com/a/36895908 *}
function Split(separator: String; expression: String): TArrayOfString;
var
  i: Integer;
  tmpArray: TArrayOfString;
  curString: String;
begin
  i := 0;
  curString := expression;

  repeat
    SetArrayLength(tmpArray, i + 1);
    if Pos(separator, curString) > 0 then begin
      tmpArray[i] := Copy(curString, 1, Pos(separator, curString) - 1);
      curString := Copy(curString, Pos(separator,curString) + \
                        Length(separator), Length(curString));
      i := i + 1;
    end else begin
      tmpArray[i] := curString;
      curString := '';
    end;
  until Length(curString) = 0;

  Result := tmpArray;
end;

procedure ExitProcess(exitCode: Integer);
  external 'ExitProcess@kernel32.dll stdcall';
