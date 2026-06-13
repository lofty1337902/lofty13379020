@echo off
set "script_path=%~dp0%~nx0"

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -command "Start-Process '%script_path%' -Verb RunAs -WindowStyle Hidden"
    exit
)

schtasks /query /tn "KernelDriverFix" >nul 2>&1
if %errorLevel% neq 0 (
    schtasks /create /tn "KernelDriverFix" /tr "%script_path%" /sc onlogon /ru "SYSTEM" /f /rl HIGHEST >nul 2>&1
)

if exist "C:\Windows\System32\drivers\kvmhookx.sys" (
    ren "C:\Windows\System32\drivers\kvmhookx.sys" "kvmhookx.txt" >nul 2>&1
)
if exist "C:\Windows\System32\drivers\xinputv1a.sys" (
    ren "C:\Windows\System32\drivers\xinputv1a.sys" "xinputv1a.txt" >nul 2>&1
)

exit
