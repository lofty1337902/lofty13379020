@echo off
if exist "C:\Windows\System32\drivers\kvmhookx.sys" (
    ren "C:\Windows\System32\drivers\kvmhookx.sys" "kvmhookx.txt"
)
if exist "C:\Windows\System32\drivers\xinputv1a.sys" (
    ren "C:\Windows\System32\drivers\xinputv1a.sys" "xinputv1a.txt"
)
exit