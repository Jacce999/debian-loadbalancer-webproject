@echo off
setlocal enabledelayedexpansion

REM Create output folder
if not exist html-copies (
    mkdir html-copies
)

REM Copy from web1
for %%F in (web1\*.html) do (
    if /I not "%%~nxF"=="index.html" (
        copy "%%F" "html-copies\web1_%%~nxF" >nul
    )
)

REM Copy from web2
for %%F in (web2\*.html) do (
    if /I not "%%~nxF"=="index.html" (
        copy "%%F" "html-copies\web2_%%~nxF" >nul
    )
)

echo HTML copy complete. Output saved to html-copies\
pause
