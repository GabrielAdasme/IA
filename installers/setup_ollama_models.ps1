Write-Host "==== Instalando Ollama ===="

$installer = "$env:TEMP\ollama.exe"

Invoke-WebRequest -Uri "https://ollama.com/download/OllamaSetup.exe" -OutFile $installer

Start-Process -FilePath $installer -Wait

Write-Host "Ollama instalado!"

Start-Sleep -Seconds 5

Write-Host "Iniciando serviço Ollama..."
Start-Process "C:\Program Files\Ollama\ollama.exe"
Start-Sleep -Seconds 10

Write-Host "==== Baixando modelos ===="

Write-Host "-> deepseek-coder"
ollama pull deepseek-coder

Write-Host "-> llama3.1"
ollama pull llama3.1

Write-Host "Modelos instalados com sucesso!"
