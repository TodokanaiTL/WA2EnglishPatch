[Code]
#ifndef VARS
#define VARS
var
  ErrorCounter: Integer;
  EV000_DL, EV150_DL: Boolean;
#endif

procedure DownloadVideoCC(MVURL: String; MVName: String; MVSize: Integer);
begin
  if IsComponentSelected('subbedvideos\' + MVName) then begin
    Log(MVName + ' has been selected to download.');
    if not FileExists(ExpandConstant('{app}\' + MVName + '.pak.BKP')) then begin
      Log('BKP file does not already exist.');
      if RenameFile(ExpandConstant('{app}\' + MVName + '.pak'), ExpandConstant('{app}\' + MVName + '.pak.BKP')) then begin
        Log('Succesfully created BKP file.');
      end else begin
        Log('Failed to create BKP file.');
        ErrorCounter := ErrorCounter + 1;
      end; 
      idpAddFileSizeComp(MVURL, ExpandConstant('{tmp}\' + MVName + '.pak'), MVSize, MVName);
    end else begin
      Log('BKP file already exists. ' + MVName + '.pak will not be downloaded.');
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
      Log('BKP file does not already exist.');
      if RenameFile(ExpandConstant('{app}\IC\' + MVName + '.pak'), ExpandConstant('{app}\IC\' + MVName + '.pak.BKP')) then begin
        Log('Succesfully created BKP file.');
      end else begin
        Log('Failed to create BKP file.');
        ErrorCounter := ErrorCounter + 1;
      end; 
      idpAddFileSizeComp(MVURL, ExpandConstant('{tmp}\' + MVName + '.pak'), MVSize, MVName);
    end else begin
      Log('BKP file already exists. ' + MVName + '.pak will not be downloaded.');
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
      'ev000': EV000_DL := True;
      'ev150': EV150_DL := True;
    end;
  end else begin
    Log(PFName + '.pak already exists. It will not be downloaded.');
  end;
end;

procedure IsFileDownloaded(DLName: String; DLPath: String);
begin
  if FileExists(ExpandConstant('{app}\' + DLPath)) then begin
    Log('Succesfully downloaded ' + DLName + '.pak.');
  end else begin
    Log('Failed to download ' + DLName + '.pak.');
    ErrorCounter := ErrorCounter + 1;
  end;
end;