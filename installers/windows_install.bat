@echo off
title Instalador - Mocha Local AI (Windows)

echo =====================================================
echo          Mocha Local AI - Instalador Windows
echo =====================================================
echo.

REM ---- VERIFICAR PERMISSÕES ADMINISTRATIVAS ----
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo [ERRO] Este instalador precisa ser executado como Administrador.
    pause
    exit /b
)

echo [OK] Permissão administrativa confirmada.
echo.

REM ---- VERIFICAR O POWERSHELL ----
where powershell >nul 2>&1
if %errorlevel% NEQ 0 (
    echo [ERRO] PowerShell não encontrado. Windows precisa dele.
    pause
    exit /b
)

REM ---- CRIAR ESTRUTURA DE PASTAS ----
echo Criando pastas necessárias...
mkdir ..\..\workspace >nul 2>&1
mkdir ..\..\logs >nul 2>&1

echo.

REM ---- INSTALAR NODE ----
echo Verificando Node.js...
where node >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Node não encontrado.
    echo Baixando instalador...
    powershell -Command "Invoke-WebRequest -Uri https://nodejs.org/dist/v18.18.0/node-v18.18.0-x64.msi -OutFile node.msi"
    echo Instalando Node.js...
    msiexec /i node.msi /qn /norestart
    del node.msi
) else (
    echo Node.js já está instalado!
)

echo.

REM ---- INSTALAR PYTHON ----
echo Verificando Python...
where python >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Python não encontrado. Baixando...
    powershell -Command "Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.11.6/python-3.11.6-amd64.exe -OutFile python.exe"
    echo Instalando Python...
    python.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del python.exe
) else (
    echo Python já instalado!
)

echo.

REM ---- INSTALAR DOCKER ----
echo Verificando Docker Desktop...
where docker >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Docker não encontrado. Baixando instalador...
    powershell -Command "Invoke-WebRequest -Uri https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe -OutFile docker_installer.exe"
    echo Instalando Docker Desktop...
    docker_installer.exe install --quiet
    del docker_installer.exe
) else (
    echo Docker Desktop já instalado!
)

echo.
echo Iniciando o Docker Desktop...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
timeout /t 10 >nul

echo Esperando Docker iniciar...
:waitloop
docker info >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Docker ainda iniciando...
    timeout /t 5 >nul
    goto waitloop
)
echo Docker iniciado com sucesso!

echo.

REM ---- INSTALAR OLLAMA ----
echo Instalando Ollama...
powershell -ExecutionPolicy Bypass -File setup_ollama_models.ps1

echo.

REM ---- INSTALAR BACKEND ----
echo Instalando backend (FastAPI + dependências)...

cd ..\backend
python -m pip install -r requirements.txt

cd ..\installers

echo.

REM ---- INSTALAR FRONTEND ----
echo Instalando dependências do frontend...
cd ..\frontend
call npm install

cd ..\installers

echo.

echo =====================================================
echo      INSTALACAO FINALIZADA COM SUCESSO!
echo =====================================================
echo.

echo Para iniciar o sistema:
echo 1) Abra 2 janelas de terminal
echo 2) Janela 1:
echo     cd backend
echo     uvicorn main:app --reload --port 8000
echo 3) Janela 2:
echo     cd frontend
echo     npm run dev
echo.
echo Backend rodará em: http://localhost:8000
echo Frontend em: http://localhost:5173
echo.

pause
exit /b
