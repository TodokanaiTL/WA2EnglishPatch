[Code]
#ifndef ERRC
#define ERRC
var
  ErrorCounter: Integer;
#endif

procedure DownloadFileCC(MVURL: String; MVName: String; MVSize: Integer);
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
      Log('BKP file already exists. ' + MVName + ' will not be downloaded.');
    end;
  end else begin
    Log(MVName + ' has not been selected to download.');
  end;
end;

procedure DownloadFileIC(MVURL: String; MVName: String; MVSize: Integer);
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
      Log('BKP file already exists. ' + MVName + ' will not be downloaded.');
    end;
  end else begin
    Log(MVName + ' has not been selected to download.');
  end;
end;

procedure IsFileDownloaded(DLName: String; DLPath: String);
begin
  if IsComponentSelected('subbedvideos\' + DLName) then begin
    if FileExists(ExpandConstant('{app}\' + DLPath + '.pak')) then begin
      Log('Succesfully downloaded ' + DLName + '.');
    end else begin
      Log('Failed to download ' + DLName + '.');
      ErrorCounter := ErrorCounter + 1;
    end;
  end;
end;
