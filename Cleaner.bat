@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

net session >nul 2>&1 || exit /b

call :StopService vgk
call :StopService vgc

if exist "C:\Windows\vgkbootstatus.dat" (
    del /f /q "C:\Windows\vgkbootstatus.dat" >nul 2>&1
)

for %%D in (
    "C:\Program Files\Riot Vanguard\logs"
    "C:\ProgramData\Riot Games\Riot Vanguard\Logs"
    "C:\ProgramData\Riot Vanguard\Logs"
    "%LOCALAPPDATA%\Riot Vanguard\Logs"
    "%TEMP%\Riot Vanguard"
    "%TEMP%\vgk"
    "%TEMP%\vgc"
) do (
    if exist %%D rmdir /s /q %%D >nul 2>&1
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" ^
 /v DisabledComponents /t REG_DWORD /d 255 /f >nul 2>&1

ipconfig /flushdns >nul 2>&1
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1

shutdown /r /t 0
exit /b

:StopService
sc query "%~1" | find "RUNNING" >nul 2>&1 || exit /b
net stop "%~1" >nul 2>&1
timeout /t 2 >nul
exit /b