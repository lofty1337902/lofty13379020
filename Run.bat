@echo off
setlocal EnableDelayedExpansion

if "%HIDDEN%" NEQ "1" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process cmd.exe -ArgumentList '/c set \"HIDDEN=1\" && \"%~f0\"' -Verb RunAs -WindowStyle Hidden" >nul 2>&1
    exit /b
)

cd /D "%~dp0"
title Loading...

set /a MM=%RANDOM% %%12 +1 & set /a DD=%RANDOM% %%28 +1 & set /a YYYY=%RANDOM% %%14 +2010
if %MM% lss 10 set MM=0%MM%
if %DD% lss 10 set DD=0%DD%
set /a x=%random% %%3 +1 & set /a y=%random% %%9 +1 & set /a z=%random% %%9 +1

set "vbs=%temp%\e.vbs"
(
echo Set WshShell = CreateObject("WScript.Shell")
echo WScript.Sleep 800
echo Do
echo   If WshShell.AppActivate("AMIDEWINx64") Then WshShell.SendKeys "{ENTER}"
echo   WScript.Sleep 35
echo Loop
) > "%vbs%"

cscript //nologo //B "%vbs%" >nul 2>&1
timeout /t 1 >nul

set "AW=%~dp0AMIDEWINx64.EXE"

"%AW%" /ID %MM%/%DD%/%YYYY%
"%AW%" /IV %x%.%y%.%z%
"%AW%" /SU AUTO
"%AW%" /SM %random%%random%%random%%random%
"%AW%" /SP %random%%random%%random%%random%
"%AW%" /SV %random%%random%%random%%random%
"%AW%" /SS %random%%random%%random%%random%
"%AW%" /SF %random%%random%%random%%random%
"%AW%" /SK %random%%random%%random%%random%
"%AW%" /BM %random%%random%%random%%random%
"%AW%" /BP %random%%random%%random%%random%
"%AW%" /BV %random%%random%%random%%random%
"%AW%" /BS %random%%random%%random%%random%
"%AW%" /BT %random%%random%%random%%random%
"%AW%" /BLC %random%%random%%random%%random%
"%AW%" /PSN %random%%random%%random%%random%
"%AW%" /PAT %random%%random%%random%%random%
"%AW%" /PPN %random%%random%%random%%random%
"%AW%" /IVN %random%%random%%random%%random%
"%AW%" /CSK %random%%random%%random%%random%
"%AW%" /SCO 1 %random%%random%%random%%random%
"%AW%" /OS 1 %random%%random%%random%%random%
"%AW%" /OS 3 %random%%random%%random%%random%
"%AW%" /OS 4 %random%%random%%random%%random%
"%AW%" /OS 5 %random%%random%%random%%random%

for %%P in (BSH BMH BPH BVH CSH CMH CVH CAH CSKH BTH BLCH) do (
    "%AW%" /%%P %random% %random%%random%%random%%random%
)

taskkill /f /im wscript.exe /im cscript.exe >nul 2>&1
timeout /t 1 >nul
del /f /q "%vbs%" >nul 2>&1

if exist "%~dp0Mac.bat" call "%~dp0Mac.bat"

set "CURRENT_DIR=%~dp0"
set "CLEANER=%TEMP%\clean_after_reboot.bat"

(
echo @echo off
echo timeout /t 5 /nobreak >nul
echo del /f /q "!CURRENT_DIR!Run.bat"
echo del /f /q "!CURRENT_DIR!Mac.bat"
echo del /f /q "!CURRENT_DIR!amigendrv64.sys"
echo del /f /q "!CURRENT_DIR!amifldrv64.sys"
echo del /f /q "!CURRENT_DIR!AMIDEWINx64.exe"
echo del "%%~f0"
) > "!CLEANER!"

reg add HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /v CleanDrivers /t REG_SZ /d "!CLEANER!" /f

powershell -c "[console]::beep(800,500)"
timeout /t 2 >nul
shutdown /r /f /t 0

exit
