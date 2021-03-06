; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "PIP-OS"
#define MyAppVersion "2.1"
#define MyAppPublisher "PiSaucer"
#define MyAppURL "https://pisaucer.github.io/PIP-OS/"
#define MyAppExeName "fallout.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{E8D3EBC7-4BB2-4583-905A-849E773CD261}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\PiSaucer\PIP-OS\
DisableDirPage=yes
DefaultGroupName={#MyAppName}
AllowNoIcons=no
OutputDir=C:\Users\alans\Desktop
OutputBaseFilename=setup
SetupIconFile=C:\Users\alans\Documents\pip boy os\installer\PiSaucer_PIP-OS\PIP-OS\icon.ico
Compression=lzma
SolidCompression=yes
DisableWelcomePage=no
VersionInfoVersion=2.1
LicenseFile=PIP-OS\LICENSE.txt
AppReadmeFile=PIP-OS\readme.txt
; WizardImageFile=PIP-OS\icon.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "C:\Users\alans\Documents\pip boy os\installer\PiSaucer_PIP-OS\PIP-OS\fallout.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\alans\Documents\pip boy os\installer\PiSaucer_PIP-OS\PIP-OS\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Messages]
WelcomeLabel2=This will install [name] on your computer.%n%nIt is recommended that you close all other applications and disable any anti virus before continuing.

[Code]

var
  UninstallFirstPage: TNewNotebookPage;
  UninstallSecondPage: TNewNotebookPage;
  UninstallBackButton: TNewButton;
  UninstallNextButton: TNewButton;

procedure UpdateUninstallWizard;
begin
  if UninstallProgressForm.InnerNotebook.ActivePage = UninstallFirstPage then
  begin
    UninstallProgressForm.PageNameLabel.Caption := 'First uninstall wizard page';
    UninstallProgressForm.PageDescriptionLabel.Caption :=
      'Ready to uninstall?';
  end
    else
  if UninstallProgressForm.InnerNotebook.ActivePage = UninstallSecondPage then
  begin
    UninstallProgressForm.PageNameLabel.Caption := 'Second uninstall wizard page';
    UninstallProgressForm.PageDescriptionLabel.Caption :=
      '';
  end;

  UninstallBackButton.Visible :=
    (UninstallProgressForm.InnerNotebook.ActivePage <> UninstallFirstPage);

  if UninstallProgressForm.InnerNotebook.ActivePage <> UninstallSecondPage then
  begin
    UninstallNextButton.Caption := SetupMessage(msgButtonNext);
    UninstallNextButton.ModalResult := mrNone;
  end
    else
  begin
    UninstallNextButton.Caption := 'Uninstall';
    { Make the "Uninstall" button break the ShowModal loop }
    UninstallNextButton.ModalResult := mrOK;
  end;
end;  

procedure UninstallNextButtonClick(Sender: TObject);
begin
  if UninstallProgressForm.InnerNotebook.ActivePage = UninstallSecondPage then
  begin
    UninstallNextButton.Visible := False;
    UninstallBackButton.Visible := False;
  end
    else
  begin
    if UninstallProgressForm.InnerNotebook.ActivePage = UninstallFirstPage then
    begin
      UninstallProgressForm.InnerNotebook.ActivePage := UninstallSecondPage;
    end;
    UpdateUninstallWizard;
  end;
end;

procedure UninstallBackButtonClick(Sender: TObject);
begin
  if UninstallProgressForm.InnerNotebook.ActivePage = UninstallSecondPage then
  begin
    UninstallProgressForm.InnerNotebook.ActivePage := UninstallFirstPage;
  end;
  UpdateUninstallWizard;
end;

procedure InitializeUninstallProgressForm();
var
  PageText: TNewStaticText;
  PageNameLabel: string;
  PageDescriptionLabel: string;
  CancelButtonEnabled: Boolean;
  CancelButtonModalResult: Integer;
begin
  if not UninstallSilent then
  begin
    { Create the first page and make it active }
    UninstallFirstPage := TNewNotebookPage.Create(UninstallProgressForm);
    UninstallFirstPage.Notebook := UninstallProgressForm.InnerNotebook;
    UninstallFirstPage.Parent := UninstallProgressForm.InnerNotebook;
    UninstallFirstPage.Align := alClient;

    PageText := TNewStaticText.Create(UninstallProgressForm);
    PageText.Parent := UninstallFirstPage;
    PageText.Top := UninstallProgressForm.StatusLabel.Top;
    PageText.Left := UninstallProgressForm.StatusLabel.Left;
    PageText.Width := UninstallProgressForm.StatusLabel.Width;
    PageText.Height := UninstallProgressForm.StatusLabel.Height;
    PageText.AutoSize := False;
    PageText.ShowAccelChar := False;
    PageText.Caption := 'Press Next to proceeed with uninstallation.';

    UninstallProgressForm.InnerNotebook.ActivePage := UninstallFirstPage;

    PageNameLabel := UninstallProgressForm.PageNameLabel.Caption;
    PageDescriptionLabel := UninstallProgressForm.PageDescriptionLabel.Caption;

    { Create the second page }

    UninstallSecondPage := TNewNotebookPage.Create(UninstallProgressForm);
    UninstallSecondPage.Notebook := UninstallProgressForm.InnerNotebook;
    UninstallSecondPage.Parent := UninstallProgressForm.InnerNotebook;
    UninstallSecondPage.Align := alClient;

    PageText := TNewStaticText.Create(UninstallProgressForm);
    PageText.Parent := UninstallSecondPage;
    PageText.Top := UninstallProgressForm.StatusLabel.Top;
    PageText.Left := UninstallProgressForm.StatusLabel.Left;
    PageText.Width := UninstallProgressForm.StatusLabel.Width;
    PageText.Height := UninstallProgressForm.StatusLabel.Height;
    PageText.AutoSize := False;
    PageText.ShowAccelChar := False;
    PageText.Caption := 'Press Uninstall to proceeed with uninstallation.';

    UninstallNextButton := TNewButton.Create(UninstallProgressForm);
    UninstallNextButton.Parent := UninstallProgressForm;
    UninstallNextButton.Left :=
      UninstallProgressForm.CancelButton.Left -
      UninstallProgressForm.CancelButton.Width -
      ScaleX(10);
    UninstallNextButton.Top := UninstallProgressForm.CancelButton.Top;
    UninstallNextButton.Width := UninstallProgressForm.CancelButton.Width;
    UninstallNextButton.Height := UninstallProgressForm.CancelButton.Height;
    UninstallNextButton.OnClick := @UninstallNextButtonClick;

    UninstallBackButton := TNewButton.Create(UninstallProgressForm);
    UninstallBackButton.Parent := UninstallProgressForm;
    UninstallBackButton.Left :=
      UninstallNextButton.Left - UninstallNextButton.Width -
      ScaleX(10);
    UninstallBackButton.Top := UninstallProgressForm.CancelButton.Top;
    UninstallBackButton.Width := UninstallProgressForm.CancelButton.Width;
    UninstallBackButton.Height := UninstallProgressForm.CancelButton.Height;
    UninstallBackButton.Caption := SetupMessage(msgButtonBack);
    UninstallBackButton.OnClick := @UninstallBackButtonClick;
    UninstallBackButton.TabOrder := UninstallProgressForm.CancelButton.TabOrder;

    UninstallNextButton.TabOrder := UninstallBackButton.TabOrder + 1;

    UninstallProgressForm.CancelButton.TabOrder := UninstallNextButton.TabOrder + 1;

    { Run our wizard pages } 
    UpdateUninstallWizard;
    CancelButtonEnabled := UninstallProgressForm.CancelButton.Enabled
    UninstallProgressForm.CancelButton.Enabled := True;
    CancelButtonModalResult := UninstallProgressForm.CancelButton.ModalResult;
    UninstallProgressForm.CancelButton.ModalResult := mrCancel;

    if UninstallProgressForm.ShowModal = mrCancel then Abort;

    { Restore the standard page payout }
    UninstallProgressForm.CancelButton.Enabled := CancelButtonEnabled;
    UninstallProgressForm.CancelButton.ModalResult := CancelButtonModalResult;

    UninstallProgressForm.PageNameLabel.Caption := PageNameLabel;
    UninstallProgressForm.PageDescriptionLabel.Caption := PageDescriptionLabel;

    UninstallProgressForm.InnerNotebook.ActivePage :=
      UninstallProgressForm.InstallingPage;
  end;
end;

