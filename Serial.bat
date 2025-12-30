@echo off
chcp 65001 > nul
title Lofty Software Serial Checker
color 0C
if "%~1" neq "_DH" start /min "" "%~f0" _DH & exit /b

:start
cls
echo ============================================
echo.

echo ██      ███████ ███████ ████████ ██  ██
echo ██      ██   ██ ██         ██    ██  ██
echo ██      ██   ██ █████      ██    ██████
echo ██      ██   ██ ██         ██      ██
echo ███████ ███████ ██         ██      ██
echo. 

echo.
echo ============================================
echo.
echo ============================================
echo    Hardware Serial Numbers
echo ============================================
echo.

echo MOTHERBOARD:
wmic baseboard get serialnumber

echo.
echo BIOS:
wmic bios get serialnumber

echo.
echo CPU:
wmic cpu get serialnumber

echo.
echo DISK:
wmic diskdrive get serialnumber,model

echo.
echo RAM:
wmic memorychip get SerialNumber

echo.
echo SMBIOS:
wmic path win32_computersystemproduct get IdentifyingNumber

echo.
echo TPM:
powershell.exe -Command "Write-Host '' -NoNewline; Write-Host (Get-TpmEndorsementKeyInfo -Hash Sha256).PublicKeyHash"

echo.
echo MAC Address:
ipconfig /all | findstr "Physical Address"

echo.
echo ============================================
echo.
echo Press Enter To Refresh...
pause >nul
goto start
