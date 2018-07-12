[Code]
{* Verify file MD5 *}
function VerifyMD5(file: String; expectedMD5: String): Boolean;
var
  fileMD5: String;

begin
  try
    fileMD5 := GetMD5OfFile(ExpandConstant(file));
  except
    ShowExceptionMessage;
  end
  Result := (fileMD5 = expectedMD5);
end;

{* Download necessary patch files *}
function DownloadPatchFile(url: String; file: String; size: Integer; \
                           dest: String; md5: String): Boolean;
begin
  if FileExists(ExpandConstant(dest + file))
  and VerifyMD5(dest + file, md5) then begin
    Log(file + ' already exists.');
    Result := False;
    Exit;
  end
  Log('Downloading ' + file)
  idpAddFileSize(url, ExpandConstant('{tmp}\' + file), size);
  Result := True;
end;

{* Download component files and make backups *}
function DownloadCompFile(url: String; file: String; size: Integer; \
                          dest: String; md5: String; comp: String): Boolean;
begin
  Result := True;
  if not IsComponentSelected(comp) then begin
    Log(file + ' hasn''t been selected.');
    Result := False;
    Exit;
  end
  Log(file + ' has been selected.');
  if FileExists(ExpandConstant(dest + file)) then begin
    if VerifyMD5(dest + file, md5) then begin
      Log(file + ' already exists.');
      Result := False;
      Exit;
    end
    if RenameFile(ExpandConstant(dest + file), \
                  ExpandConstant(dest + file + '.BKP'))
    then Log('Succesfully created BKP file.')
    else Log('Error. Failed to create BKP file.');
  end
  Log('Downloading ' + file);
  idpAddFileSizeComp(url, ExpandConstant('{tmp}\' + file), size, file);
end;

{* Log MD5 checksum of downloaded files *}
procedure LogFileMD5(file: String; expectedMD5: String);
var
  fileMD5: String;
  baseName: String;
  err: String;

begin
  if FileExists(ExpandConstant(file)) then begin
    try
      baseName := ExtractFileName(file);
      fileMD5 := GetMD5OfFile(ExpandConstant(file));
    except
       ShowExceptionMessage;
    end;
    Log('MD5 hash of ' + baseName + \
        ': ' + AnsiUppercase(fileMD5) + '.');
    if (baseName = 'en.pak') then begin
      Log('File hash cannot be verified automatically.' + \
          ' (This is not an error.)');
    end else begin
      if (fileMD5 = expectedMD5) then begin
        Log('File hash matches expected hash.');
      end else begin
        Log('Error. Expected: ' + AnsiUppercase(expectedMD5) + '.');
        err := baseName + ' appears to be corrupt. Delete it' + \
               ' and run the installer again to redownload it.';
        MsgBox(err, mbError, MB_OK);
      end;
    end;
  end else begin
    Log('Error. ' + baseName + ' could not be found.');
    err := 'Failed to download ' + baseName + \
           ' Run the installer again to redownload it.';
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
var
  isInHKLM: Boolean;

begin
  if IsWin64 then isInHKLM := RegKeyExists(HKLM64, key)
  else isInHKLM := RegKeyExists(HKLM32, key);
  Result := (isInHKLM or RegKeyExists(HKCU, key));
end;

{* Check if running on wine *}
function IsWine(): Boolean;
begin
  Result := CheckRegistry('Software\Wine');
end;

{* Check the registry for WA2 *}
function IsInstalled(): Boolean;
begin
  Result := CheckRegistry('Software\Leaf\WHITE ALBUM2');
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

{* End *}

