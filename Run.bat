@echo off
setlocal EnableDelayedExpansion

:: --- Eğer HIDDEN=1 değilse, kendini gizli ve yükseltilmiş olarak yeniden başlat ---
if "%HIDDEN%" NEQ "1" (
    echo Loading...
    rem Komutu gizli ve yönetici olarak başlat. UAC gerekiyorsa Windows gösterir.
    powershell -NoProfile -Command "Start-Process -FilePath 'cmd.exe' -ArgumentList '/c set HIDDEN=1&& ""%~f0""' -Verb RunAs -WindowStyle Hidden"
    exit /b
)

:: Buradan itibaren: GİZLİ (ve gerekiyorsa YÜKSELTİLMİŞ) kopya çalışıyor.
:: -------------------------------
:: Rastgele tarih ve versiyon (orijinal)
:: -------------------------------
set /a MM=%RANDOM% %% 12 + 1
set /a DD=%RANDOM% %% 28 + 1
set /a YYYY=%RANDOM% %% 14 + 2010
if !MM! LSS 10 set MM=0!MM!
if !DD! LSS 10 set DD=0!DD!

set /a x=%random% %% 3 + 1
set /a y=%random% %% 9 + 1
set /a z=%random% %% 9 + 1

cd /D "%~dp0"

:: -------------------------------
:: Temporary VBScript oluştur: AMIDEWINx64 penceresine sürekli Enter basar
:: -------------------------------
set "vbsfile=%temp%\sendenter.vbs"
(
echo Set WshShell = WScript.CreateObject("WScript.Shell")
echo WScript.Sleep 1000
echo Do While True
echo     On Error Resume Next
echo     For Each w In WshShell.AppActivate("AMIDEWINx64")
echo         WshShell.SendKeys "{ENTER}"
echo         WScript.Sleep 50
echo     Next
echo Loop
) > "%vbsfile%"

:: VBScript'i arka planda çalıştır (wscript, GUI olmayan işlemle çalışır)
start "" wscript.exe "%vbsfile%"

:: -------------------------------
:: AMIDEWINx64 komutları (orijinal tüm sıra)
:: -------------------------------
echo Loading...
"%~dp0AMIDEWINx64.EXE" /ID !MM!/!DD!/!YYYY!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /SV !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /SS !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /SF !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /SU AUTO
echo Loading...
"%~dp0AMIDEWINx64.EXE" /SK !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /SF !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BV !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BS !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BT !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BLC !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CV !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CS !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CM !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CA !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CSK !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /PSN !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /PAT !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /PPN !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BSH 3 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BMH 3 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BPH 3 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BVH 3 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CSH 4 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CMH 4 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CVH 4 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CAH 4 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /CSKH 4 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BTH 3 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BLCH 3 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /IVN !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /IV !x!.!y!.!z!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /SM !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /SP !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BM !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /BP !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /SCO 1 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /OS 1 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /OS 3 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /OS 4 !random!!random!!random!!random!
echo Loading...
"%~dp0AMIDEWINx64.EXE" /OS 5 !random!!random!!random!!random!

:: -------------------------------
:: AMIDEWINx64 tamamlandığında VBScript'i durdur
:: -------------------------------
taskkill /f /im wscript.exe >nul 2>&1
del "%vbsfile%" >nul 2>&1

:: -------------------------------
:: Mac.bat çalıştır
:: -------------------------------
echo Loading...
if exist "%~dp0Mac.bat" (
    echo Loading...
    call "%~dp0Mac.bat"
) else (
    echo Loading...
)

:: -------------------------------
:: İşlem tamam mesajı ve otomatik yeniden başlat
:: -------------------------------
echo Loading...
shutdown /r /t 5 /f
exit /b