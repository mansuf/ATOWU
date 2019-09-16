@echo off
title ATOWU Installer v0.2
echo Extracting....
set DIR=%cd%
set DIR_INSTALL=C:\ATOWU
if not exist "%DIR_INSTALL%" md %DIR_INSTALL%
goto Check_files

:Check_files
echo.
if not exist "%DIR%\ATOWU_DATA.1" goto FAILED_DATA_1
if not exist "%DIR%\ATOWU_DATA.2" goto FAILED_DATA_2
if not exist "%DIR%\ATOWU_DATA.3" goto FAILED_DATA_3
if not exist "%DIR%\ATOWU_DATA.4" goto FAILED_DATA_4
goto install_v2

:FAILED_DATA_1
echo ATOWU_DATA.1 is missing
echo if moved find it, if deleted download again
pause>NUL
exit

:FAILED_DATA_2
echo ATOWU_DATA.2 is missing
echo if moved find it, if deleted download again
pause>NUL
exit

:FAILED_DATA_3
echo ATOWU_DATA.3 is missing
echo if moved find it, if deleted download again
pause>NUL
exit

:FAILED_DATA_4
echo ATOWU_DATA.4 is missing
echo if moved find it, if deleted download again
pause>NUL
exit

:install_v2
echo.
copy /Y "%DIR%\ATOWU_DATA.1" %DIR_INSTALL%
copy /Y "%DIR%\ATOWU_DATA.2" %DIR_INSTALL%
copy /Y "%DIR%\ATOWU_DATA.3" %DIR_INSTALL%
copy /Y "%DIR%\ATOWU_DATA.4" %DIR_INSTALL%
rename "%DIR_INSTALL%\ATOWU_DATA.1" ATOWU.bat
rename "%DIR_INSTALL%\ATOWU_DATA.2" ScriptBackground.vbs
rename "%DIR_INSTALL%\ATOWU_DATA.3" ATOWU_Run_in_Background.cmd
rename "%DIR_INSTALL%\ATOWU_DATA.4" LessMode_Activator.cmd
goto Check_after_install_v2

:Check_after_install_v2
if not exist "%DIR_INSTALL%\ATOWU.bat" (
    copy /Y "%DIR%\ATOWU_DATA.1" %DIR_INSTALL%
    rename "%DIR_INSTALL%\ATOWU_DATA.1" ATOWU.bat
)
if not exist "%DIR_INSTALL%\ScriptBackground.vbs" (
    copy /Y "%DIR%\ATOWU_DATA.2" %DIR_INSTALL%
    rename "%DIR_INSTALL%\ATOWU_DATA.2" ScriptBackground.vbs
)
if not exist "%DIR_INSTALL%\ATOWU_Run_in_Background.cmd" (
    copy /Y "%DIR%\ATOWU_DATA.3" %DIR_INSTALL%
    rename "%DIR_INSTALL%\ATOWU_DATA.3" ATOWU_Run_in_Background.cmd
)
if not exist "%DIR_INSTALL%\LessMode_Activator.cmd" (
    copy /Y "%DIR%\ATOWU_DATA.4" %DIR_INSTALL%
    rename "%DIR_INSTALL%\ATOWU_DATA.4" LessMode_Activator.cmd
)
goto Result_Install_Checker

:Result_Install_Checker
if exist "%DIR_INSTALL%\ATOWU.bat" (
    set _atowu_=1
) else (
    set _atowu_=0
)
if exist "%DIR_INSTALL%\ScriptBackground.vbs" (
    set _vbs_=1
) else (
    set _vbs_=0
)
if exist "%DIR_INSTALL%\ATOWU_Run_in_Background.cmd" (
    set _cmd_=1
) else (
    set _cmd_=0
)
if exist "%DIR_INSTALL%\LessMode_Activator.cmd" (
    set _cmd1_=1
) else (
    set _cmd1_=0
)
goto Result_Install

:Result_Install
cls
echo Result Install
if %_atowu_%==1 (
    echo ATOWU.bat Successfully Installed
) else (
    echo ATOWU.bat Failed to install
)
if %_vbs_%==1 (
    echo ScriptBackground.vbs Successfully Installed
) else (
    echo ScriptBackground.vbs Failed to install
)
if %_cmd_%==1 (
    echo ATOWU_Run_in_Background.cmd Successfully Installed
) else (
    echo ATOWU_Run_in_Background.cmd Failed to Install
)
if %_cmd1_%==1 (
    echo LessMode_Activator.cmd Successfully Installed
) else (
    echo LessMode_Activator.cmd Failed to Install
)
echo.
echo.
echo Successfully install ATOWU Enjoy! :D
echo PRESS ANY BUTTON TO CLOSE THIS (NOT THE POWER BUTTON, BRUH...)
pause>NUL
exit