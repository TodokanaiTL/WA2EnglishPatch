[Code]
{* Download necessary patch files *}
function DownloadPatchFile(url: String; file: String; size: Integer; dest: String): Boolean;
begin
  if not FileExists(ExpandConstant(dest + file)) then begin
    Log('Downloading ' + file)
    idpAddFileSize(url, ExpandConstant('{tmp}\' + file), size);
    Result := True;
  end else begin
    Log(file + ' already exists.');
    Result := False;
  end;
end;

{* Download component files and make backups *}
function DownloadCompFile(url: String; file: String; size: Integer; dest: String; comp: String): Boolean;
begin
  if IsComponentSelected(comp) then begin
    Log(file + ' has been selected.');
    if FileExists(ExpandConstant(dest + file)) then begin
      if FileExists(ExpandConstant(dest + file + '.BKP')) then begin
        Log(file + ' already exists.');
        Result := False;
      end else begin
        if RenameFile(ExpandConstant(dest + file), ExpandConstant(dest + file + '.BKP')) then begin
          Log('Succesfully created BKP file.');
        end else begin
          Log('Error. Failed to create BKP file.');
        end;
        Log('Downloading ' + file);
        idpAddFileSizeComp(url, ExpandConstant('{tmp}\' + file), size, file);
        Result := True;
      end;
    end else begin
      Log('Downloading ' + file);
      idpAddFileSizeComp(url, ExpandConstant('{tmp}\' + file), size, file);
      Result := True;
    end;
  end else begin
    Log(file + ' hasn''t been selected.');
    Result := False;
  end;
end;

{* Log MD5 checksum of downloaded files *}
procedure LogFileMD5(file: String; expectedMD5: String; dir: String);
var
  fileMD5: String;

begin
  if FileExists(ExpandConstant(dir + file)) then begin
    try
      fileMD5 := GetMD5OfFile(ExpandConstant(dir + file));
    except
       ShowExceptionMessage;
    end;
    Log('MD5 hash of ' + file + ': ' + AddPeriod(AnsiUppercase(fileMD5)))
    if (file = 'en.pak') then begin
      Log('File hash cannot be verified automatically. (This is not an error.)');
    end else begin
      if (fileMD5 = expectedMD5) then begin
        Log('File hash matches expected hash.');
      end else begin
        Log('Error. Expected: ' + AddPeriod(AnsiUppercase(expectedMD5)));
        MsgBox(file + ' appears to be corrupt. ' + 'Please delete it ' + \
              'and run the installer again to redownload it.', mbError, MB_OK);
      end;
    end;
  end else begin
    Log('Error. ' + file + ' could not be found.');
    MsgBox('Failed to download ' + file + ' Please run the installer again to redownload it.', mbError, MB_OK);
  end;
end;

{* Get HKLM corresponding to architecture *}
function GetHKLM: Integer;
begin
  if IsWin64 then Result := HKLM64
  else Result := HKLM32;
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
      curString := Copy(curString, Pos(separator,curString) + Length(separator), Length(curString));
      i := i + 1;
    end else begin
      tmpArray[i] := curString;
      curString := '';
    end;
  until Length(curString) = 0;

  Result:= tmpArray;
end;

{* End *}

