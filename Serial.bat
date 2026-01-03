@echo off
mode con: cols=100 lines=40
title Serial Checker
color 0F

:start
cls
echo.

echo [36m^> [36mCPU[37m
wmic cpu get serialnumber

echo.
echo [36m^> [36mBIOS[37m
wmic bios get serialnumber

echo.
echo [36m^> [36mMOTHERBOARD[37m
wmic baseboard get serialnumber

echo.
echo [36m^> [36mBIOS UUID[37m
wmic path win32_computersystemproduct get uuid

echo.
echo [36m^> [36mDISK[37m
wmic diskdrive get model, serialnumber

echo.
echo [36m^> [36mMAC[37m
for /f "tokens=*" %%A in ('getmac ^| findstr /R /V "^$"') do echo %%A

echo.
echo [36m^> [36mTPM[37m
powershell -Command "(Get-TpmEndorsementKeyInfo -Hash Sha256).PublicKeyHash"

echo.
<nul set /p "=Press Enter To Refresh..."
set /p "="
goto start
