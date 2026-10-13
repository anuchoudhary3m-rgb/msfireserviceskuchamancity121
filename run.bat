@echo off
title MS Fire Safety - Local Preview Server
cd /d "%~dp0"
echo Starting MS Fire Safety Local Web Server...
echo Opening http://localhost:5500 in your browser...
powershell -ExecutionPolicy Bypass -File "start_preview.ps1"
pause
