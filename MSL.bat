@echo off
title LOADING MSL...
color 0a
echo LOADING SCRIPT...
timeout 1 > NUL
echo CREATING SERVER HISTORY FILE...
timeout 1 > NUL
echo SEARCHING FOR HISTORY SERVERS
timeout 1 > NUL
echo COMPLETE. Press enter to load script.
timeout -1 > NUL

:: Fichier pour stocker l'historique des serveurs
set "history_file=server_history.txt"
if not exist "%history_file%" echo. > "%history_file%"

:menu
title MSL V1
cls
echo ============================================
echo        Minecraft Server Launcher
echo ============================================
echo [1] New Server
echo [2] Launch Old Server
echo [3] History
echo [4] Exit
echo ============================================
set /p choice="Choisissez une option : "

if "%choice%"=="1" goto start_new_server
if "%choice%"=="2" goto start_from_history
if "%choice%"=="3" goto show_history
if "%choice%"=="4" goto exit
echo %choice% are not an valid option.
pause
goto menu

:start_new_server
cls
echo ============================================
echo       New Server
echo ============================================
echo Enter .bat server path...
echo Example : C:\path\to\server\start.bat
echo ============================================
set /p serverpath="Chemin : "

if exist "%serverpath%" (
    echo Launching Server...
    start "" "%serverpath%"
    echo %serverpath% >> "%history_file%"
    echo SERVER LAUNCHED) else (
    echo Error : Invalid Format.
    pause
)

pause
goto menu

:start_from_history
cls
echo ============================================
echo    Launch Server From History
echo ============================================
if not exist "%history_file%" (
    echo No History !
    pause
    goto menu
)

:: Affiche les options disponibles
setlocal enabledelayedexpansion
set index=0
for /f "tokens=*" %%A in (%history_file%) do (
    set /a index+=1
    echo [!index!] %%A
    set "server_!index!=%%A"
)

if %index%==0 (
    echo No Saved Server In History.
    pause
    goto menu
)

echo ============================================
set /p server_choice="Please enter server number : "

:: Valide le choix
if defined server_%server_choice% (
    set "selected_server=!server_%server_choice%!"
    echo Lancement du serveur : !selected_server!
    start "" "!selected_server!"
    echo SERVER LAUNCHED
) else (
    echo Erreur : Sélection invalide.
)

pause
goto menu

:show_history
cls
echo ============================================
echo             Server History
echo ============================================
if not exist "%history_file%" (
    echo No History !
) else (
    type "%history_file%"
)
echo ============================================
pause
goto menu

:exit
echo Closing Script...
timeout 2 > NUL
exit
