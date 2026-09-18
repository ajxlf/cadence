@echo off
cd /d "%~dp0"
start "FightFlow Server" cmd /c "py -m http.server 8000"
timeout /t 1 /nobreak >nul
start "" "http://localhost:8000/"
