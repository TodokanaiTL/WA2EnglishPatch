[Code]
#ifndef _VAR_
#define _VAR_
var
  errorCounter: Integer;
  ev000_DL, eV150_DL: Boolean;
#endif

procedure DownloadVideoCC(MVURL: String; MVName: String; MVSize: Integer);
begin
  if IsComponentSelected('subbedvideos\' + MVName) then begin
    Log(MVName + ' has been selected to download.');
    if not FileExists(ExpandConstant('{app}\' + MVName + '.pak.BKP')) then begin
      if RenameFile(ExpandConstant('{app}\' + MVName + '.pak'), ExpandConstant('{app}\' + MVName + '.pak.BKP')) then begin
        Log('Succesfully created BKP file.');
      end else begin
        Log('Failed to create BKP file.');
        errorCounter := errorCounter + 1;
      end; 
      idpAddFileSizeComp(MVURL, ExpandConstant('{tmp}\' + MVName + '.pak'), MVSize, MVName);
    end else begin
      Log(MVName + '.pak is already downloaded.');
    end;
  end else begin
    Log(MVName + '.pak has not been selected to download.');
  end;
end;

procedure DownloadVideoIC(MVURL: String; MVName: String; MVSize: Integer);
begin
  if IsComponentSelected('subbedvideos\' + MVName) then begin
    Log(MVName + ' has been selected to download.');
    if not FileExists(ExpandConstant('{app}\IC\' + MVName + '.pak.BKP')) then begin
      if RenameFile(ExpandConstant('{app}\IC\' + MVName + '.pak'), ExpandConstant('{app}\IC\' + MVName + '.pak.BKP')) then begin
        Log('Succesfully created BKP file.');
      end else begin
        Log('Failed to create BKP file.');
        errorCounter := errorCounter + 1;
      end; 
      idpAddFileSizeComp(MVURL, ExpandConstant('{tmp}\' + MVName + '.pak'), MVSize, MVName);
    end else begin
      Log(MVName + '.pak is already downloaded.');
    end;
  end else begin
    Log(MVName + '.pak has not been selected to download.');
  end;
end;

procedure DownloadPatchFile(PFURL: String; PFName: String; PFSize: Integer);
begin
  if not FileExists(ExpandConstant('{app}\' + PFName + '.pak')) then begin
    Log(PFName + '.pak does not already exist. Downloading.')
    idpAddFileSize(PFURL, ExpandConstant('{tmp}\' + PFName + '.pak'), PFSize);
    case (PFName) of
      'ev000': ev000_DL := True;
      'ev150': ev150_DL := True;
    end;
  end else begin
    Log(PFName + '.pak already exists. It will not be downloaded.');
  end;
end;

procedure IsFileDownloaded(DLName: String; DLPath: String);
begin
  if FileExists(ExpandConstant('{app}\' + DLPath)) then begin
    Log('Succesfully downloaded ' + AddPeriod(DLName));
  end else begin
    Log('Failed to download ' + AddPeriod(DLName));
    errorCounter := errorCounter + 1;
  end;
end;

procedure LogMD5CC(NameOfFile: String; ExpectedMD5: String);
var
  MD5OfFile: String;
begin
  if FileExists(ExpandConstant('{app}\' + NameOfFile)) then begin
    try
      MD5OfFile := GetMD5OfFile(ExpandConstant('{app}\' + NameOfFile));
    except
       MsgBox('Exception raised: ' + AddPeriod(GetExceptionMessage), mbError, MB_OK);
    end;
    Log('MD5 hash of ' + NameOfFile + ': ' + AddPeriod(AnsiUppercase(MD5OfFile)))
    if (NameOfFile = 'en.pak') then begin
      Log('Hash cannot be verified automatically.');
    end else begin
      if (CompareText(MD5OfFile, ExpectedMD5) = 0) then begin
        Log('File hash matches expected hash.');
      end else begin 
        Log('Expected: ' + AddPeriod(AnsiUppercase(ExpectedMD5)));
      end;
    end;
  end else begin
    Log(NameOfFile + ' could not be found.');
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
      Log('Expected: ' + AddPeriod(AnsiUppercase(ExpectedMD5)));
    end;
  end else begin
    Log(NameOfFile + ' could not be found.');
  end;
end;
