[Code]
var
  MD5OfFile: String;
#ifndef _DL_
#define _DL_
  ev000_DL, eV150_DL: Boolean;
#endif

procedure DownloadVideoCC(MVURL: String; MVName: String; MVSize: Integer);
begin
  if IsComponentSelected('subbedvideos\' + MVName) then begin
    Log(MVName + ' has been selected.');
    if not FileExists(ExpandConstant('{app}\' + MVName + '.pak.BKP')) then begin
      if RenameFile(ExpandConstant('{app}\' + MVName + '.pak'), ExpandConstant('{app}\' + MVName + '.pak.BKP')) then begin
        Log('Succesfully created BKP file.');
        Log('Downloading ' + MVName + '.pak');
      end else begin
        Log('Error. Failed to create BKP file.');
        Log('Downloading ' + MVName + '.pak');
      end; 
      idpAddFileSizeComp(MVURL, ExpandConstant('{tmp}\' + MVName + '.pak'), MVSize, MVName);
    end else begin
      Log(MVName + '.pak already exists.');
    end;
  end else begin
    Log(MVName + '.pak hasn''t been selected.');
  end;
end;

procedure DownloadVideoIC(MVURL: String; MVName: String; MVSize: Integer);
begin
  if IsComponentSelected('subbedvideos\' + MVName) then begin
    Log(MVName + ' has been selected.');
    if not FileExists(ExpandConstant('{app}\IC\' + MVName + '.pak.BKP')) then begin
      if RenameFile(ExpandConstant('{app}\IC\' + MVName + '.pak'), ExpandConstant('{app}\IC\' + MVName + '.pak.BKP')) then begin
        Log('Succesfully created BKP file.');
        Log('Downloading ' + MVName + '.pak');
      end else begin
        Log('Error. Failed to create BKP file.');
        Log('Downloading ' + MVName + '.pak');
      end; 
      idpAddFileSizeComp(MVURL, ExpandConstant('{tmp}\' + MVName + '.pak'), MVSize, MVName);
    end else begin
      Log(MVName + '.pak already exists.');
    end;
  end else begin
    Log(MVName + '.pak hasn''t been selected.');
  end;
end;

procedure DownloadPatchFile(PFURL: String; PFName: String; PFSize: Integer);
begin
  if not FileExists(ExpandConstant('{app}\' + PFName + '.pak')) then begin
    Log('Downloading ' + PFName + '.pak.')
    idpAddFileSize(PFURL, ExpandConstant('{tmp}\' + PFName + '.pak'), PFSize);
    case (PFName) of
      'ev000': ev000_DL := True;
      'ev150': ev150_DL := True;
    end;
  end else begin
    Log(PFName + '.pak already exists.');
  end;
end;

procedure LogMD5CC(NameOfFile: String; ExpectedMD5: String);
begin
  if FileExists(ExpandConstant('{app}\' + NameOfFile)) then begin
    try
      MD5OfFile := GetMD5OfFile(ExpandConstant('{app}\' + NameOfFile));
    except
       MsgBox('Exception raised: ' + AddPeriod(GetExceptionMessage), mbError, MB_OK);
    end;
    Log('MD5 hash of ' + NameOfFile + ': ' + AddPeriod(AnsiUppercase(MD5OfFile)))
    if (NameOfFile = 'en.pak') then begin
      Log('File hash cannot be verified automatically.');
    end else begin
      if (CompareText(MD5OfFile, ExpectedMD5) = 0) then begin
        Log('File hash matches expected hash.');
      end else begin 
        Log('Error. Expected: ' + AddPeriod(AnsiUppercase(ExpectedMD5)));
      end;
    end;
  end else begin
    Log('Error. ' + NameOfFile + ' could not be found.');
  end;
end;

procedure LogMD5IC(NameOfFile: String; ExpectedMD5: String);
var
  MD5OfFile: String;
begin
  if FileExists(ExpandConstant('{app}\IC\' + NameOfFile)) then begin
    try
      MD5OfFile := GetMD5OfFile(ExpandConstant('{app}\IC\' + NameOfFile));
    except
       MsgBox('Exception raised: ' + AddPeriod(GetExceptionMessage), mbError, MB_OK);
    end;
    Log('MD5 hash of ' + NameOfFile + ': ' + AddPeriod(AnsiUppercase(MD5OfFile)))
    if (CompareText(MD5OfFile, ExpectedMD5) = 0) then begin
      Log('File hash matches expected hash.');
    end else begin 
      Log('Error. Expected: ' + AddPeriod(AnsiUppercase(ExpectedMD5)));
    end;
  end else begin
    Log('Error. ' + NameOfFile + ' could not be found.');
  end;
end;

function CurDateTime: String;
begin
  Result := GetDateTimeString ('yyyy-mm-dd_hh.nn.ss', '-', '.');
end;

function GetHKLM: Integer;
begin
  if IsWin64 then
    Result := HKLM64;
  else
    Result := HKLM32;
end;
