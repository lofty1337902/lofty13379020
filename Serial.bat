@echo off
mode con: cols=100 lines=40
title Serial Checker
echo **********************************
color 0F
echo **********************************
:start
cls
echo.
echo ^> CPU
wmic cpu get serialnumber
echo.
echo ^> BIOS
wmic bios get serialnumber
echo.
echo ^> MOTHERBOARD
wmic baseboard get serialnumber
echo.
echo ^> BIOS UUID
wmic path win32_computersystemproduct get uuid
echo.
echo ^> DISK
wmic diskdrive get model, serialnumber
echo.
echo ^> MAC ADDRESS
getmac
echo.
echo ^> TPM SERIAL
powershell.exe -Command "(Get-TpmEndorsementKeyInfo -Hash Sha256).PublicKeyHash"
echo.
pause>nul
goto start