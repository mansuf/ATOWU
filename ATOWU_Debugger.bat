@ECHO OFF
echo DEBUG_MODE >> %temp%\ATOWU.DEBUG
echo b for background
echo type anything for foreground
set /p "ATOWU=Menu>"
if %ATOWU%==b echo .. > %temp%\ATOWU\ATOWU_run_in_background
"ATOWU.bat"
exit
