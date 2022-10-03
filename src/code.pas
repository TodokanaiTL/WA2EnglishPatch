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
