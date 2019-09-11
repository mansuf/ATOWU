@echo off
:Debug
cls
set BITS=NOT_FOUND
set WINDOWS_UPDATE=NOT_FOUND
set DOSVC=NOT_FOUND
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set BITS=%%b
for /f "tokens=4" %%b in ('sc query wuauserv ^| findstr STATE') do set WINDOWS_UPDATE=%%b
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set DOSVC=%%b
echo Status Background Intelligence Transfer Service : %BITS%
echo Status Windows Update : %WINDOWS_UPDATE%
echo Status Delivery Optimization : %DOSVC%
timeout 1 /nobreak>NUL
goto Debug