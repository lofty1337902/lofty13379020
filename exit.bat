@echo off
if exist "C:\Windows\System32\drivers\kvmhookx.txt" (
    ren "C:\Windows\System32\drivers\kvmhookx.txt" "kvmhookx.sys"
)
if exist "C:\Windows\System32\drivers\xinputv1a.txt" (
    ren "C:\Windows\System32\drivers\xinputv1a.txt" "xinputv1a.sys"
)
exit