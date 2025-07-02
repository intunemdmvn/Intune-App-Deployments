@echo off
cd /d "%~dp0"
setup.exe --passive --norestart --wait
timeout /t 300