; ---------------------------------------------------------------
; Mocha Local AI — Instalador Avançado com Interface Gráfica
; Criado para Windows 10/11
; ---------------------------------------------------------------

[Setup]
AppName=Mocha Local AI
AppVersion=1.0
DefaultDirName={pf}\MochaLocalAI
DefaultGroupName=Mocha Local AI
OutputBaseFilename=Mocha_Local_AI_Installer
Compression=lzma
SolidCompression=yes
;SetupIconFile=mocha.ico

[Files]
; FRONTEND
Source: "..\frontend\*"; DestDir: "{app}\frontend"; Flags: recursesubdirs

; BACKEND
Source: "..\backend\*"; DestDir: "{app}\backend"; Flags: recursesubdirs

; INSTALLER SCRIPTS
Source: "setup_ollama_models.ps1"; DestDir: "{app}\install"; Flags: ignoreversion

; SHORTCUT SCRIPTS
Source: "start_backend.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "start_frontend.bat"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Iniciar Backend"; Filename: "{app}\start_backend.bat"
Name: "{group}\Iniciar Frontend"; Filename: "{app}\start_frontend.bat"
Name: "{commondesktop}\Mocha Local AI (Frontend)"; Filename: "{app}\start_frontend.bat"

[Run]
; Node.js
Filename: "powershell"; Parameters: "-ExecutionPolicy Bypass -Command ""Invoke-WebRequest https://nodejs.org/dist/v18.18.0/node-v18.18.0-x64.msi -OutFile node.msi"""; WorkingDir: "{tmp}"
Filename: "msiexec.exe"; Parameters: "/i ""{tmp}\node.msi"" /qn"

; Python
Filename: "powershell"; Parameters: "-ExecutionPolicy Bypass -Command ""Invoke-WebRequest https://www.python.org/ftp/python/3.11.6/python-3.11.6-amd64.exe -OutFile python.exe"""; WorkingDir: "{tmp}"
Filename: "{tmp}\python.exe"; Parameters: "InstallAllUsers=1 PrependPath=1 Include_test=0 /quiet"

; Docker Desktop
Filename: "powershell"; Parameters: "-ExecutionPolicy Bypass -Command ""Invoke-WebRequest 'https://desktop.docker.com/win/main/amd64/Docker Desktop Installer.exe' -OutFile docker.exe"""; WorkingDir: "{tmp}"
Filename: "{tmp}\docker.exe"; Parameters: "install --quiet"

; Ollama + models
Filename: "powershell"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\install\setup_ollama_models.ps1"""

; Backend dependencies
Filename: "python"; Parameters: "-m pip install -r {app}\backend\requirements.txt"

; Frontend dependencies
Filename: "cmd.exe"; Parameters: "/c cd {app}\frontend && npm install"

[Code]
procedure InitializeWizard();
begin
  WizardForm.WelcomeLabel1.Caption := 'Bem-vindo ao instalador do Mocha Local AI';
  WizardForm.WelcomeLabel2.Caption := 'Este instalador instalará Python, Node, Docker, Ollama, os modelos e todo o software local.';
end;
