@echo off

REM Check if the script is run as Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo -------------------------------------------------
    echo [!] Please run this script as Administrator.
    echo -------------------------------------------------
    pause
    exit
)

echo =================================================
echo [INFO] Closing AnyDesk if it is running...
echo =================================================

REM Close AnyDesk process if it's running
taskkill /F /IM anydesk.exe >nul 2>&1
timeout /t 2 >nul

REM Check if AnyDesk is still running
tasklist /FI "IMAGENAME eq anydesk.exe" | find /I "anydesk.exe" >nul
if "%ERRORLEVEL%"=="0" (
    echo -------------------------------------------------
    echo [ERROR] AnyDesk is still running.
    echo [ACTION] Please close AnyDesk manually and rerun this script.
    echo -------------------------------------------------
    pause
    exit
) else (
    echo -------------------------------------------------
    echo [SUCCESS] AnyDesk has been closed successfully.
    echo -------------------------------------------------
)

echo =================================================
echo [INFO] Deleting AnyDesk configuration files...
echo =================================================

REM Delete AnyDesk configuration files
del /F /Q "%appdata%\AnyDesk\ad.settings"
del /F /Q "%appdata%\AnyDesk\system.conf"
del /F /Q "%programdata%\AnyDesk\ad.settings"
del /F /Q "%programdata%\AnyDesk\system.conf"

echo -------------------------------------------------
echo [INFO] Deleting AnyDesk cache data...
echo -------------------------------------------------

REM Remove AnyDesk cache folders
rmdir /S /Q "%appdata%\AnyDesk\"
rmdir /S /Q "%programdata%\AnyDesk\"

echo =================================================
echo [INFO] Opening AnyDesk to generate a new ID...
echo =================================================

REM Reopen AnyDesk
start "" "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" >nul 2>&1

echo -------------------------------------------------
echo [SUCCESS] Process completed.
echo -------------------------------------------------
pause
