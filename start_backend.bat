@echo off
title MochaLocalAI - Backend
echo ====================================
echo        MOCHA LOCAL AI - BACKEND
echo ====================================
cd /d C:\IA\backend

python -m uvicorn main:app --host 0.0.0.0 --port 8000 --reload

pause