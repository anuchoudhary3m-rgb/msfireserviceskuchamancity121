@echo off
title Push MS Fire Service to GitHub
cd /d "%~dp0"
echo ========================================================
echo Pushing MS FIRE SERVICE INDUSTRIES to GitHub:
echo https://github.com/anuchoudhary3m-rgb/msfireserviceskuchamancity.git
echo ========================================================
echo.
set "PATH=%LOCALAPPDATA%\MinGit\cmd;%PATH%"

git init -b main
git config user.name "MS Fire Safety Industries"
git config user.email "info@msfiresafetykuchamancity.com"
git remote remove origin 2>nul
git remote add origin https://github.com/anuchoudhary3m-rgb/msfireserviceskuchamancity.git

git add -A
git commit -m "MS Fire Service Industries - Complete multi-page website with SEO architecture, products, services, locations, sitemap, and GitHub Pages setup"
git branch -M main
git push -u origin main --force
echo.
if %ERRORLEVEL% equ 0 (
    echo ========================================================
    echo [SUCCESS] Complete project pushed to GitHub successfully!
    echo Repository: https://github.com/anuchoudhary3m-rgb/msfireserviceskuchamancity
    echo ========================================================
) else (
    echo ========================================================
    echo [AUTHENTICATION NOTICE]
    echo If prompted, enter your GitHub Username and Personal Access Token.
    echo ========================================================
)
echo.
pause
