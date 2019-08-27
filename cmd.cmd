::Example command VERIFICATION Variable for 
@echo off
REM echo PRESS ANY BUTTON TO OPEN THE "CONSOLE COMMAND HOST" (NOT THE POWER BUTTON, BRUH...)
REM pause>NUL
REM start "CONSOLE COMMAND HOST"


::STATUS : [TESTED & Need Improvisation]
::Command Mircrosoft_Service_Update for ATOWU Engine v2.20p1b
::Unfortunately i dont have Executable Name File (EX : ERROR.EXE)
echo --------START_SCRIPT--------
:Engine
set RESULT_ATOWU=NOT_FOUND
set PID_MICROSOFT_CLICKTORUN_SERVICE=NOT_FOUND
set STATUS_SERVICE=NOT_FOUND
set STATUS_SERVICE_IN_ENGINE=NOT_FOUND
echo start
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUS_SERVICE=%%b
for /f "tokens=2" %%b in ('tasklist ^| findstr notepad.exe') do set PID_MICROSOFT_CLICKTORUN_SERVICE=%%b
if %PID_MICROSOFT_CLICKTORUN_SERVICE%==NOT_FOUND (
    goto Engine_Process_Stop
) else (
    goto PROCESS_START
)

:Engine_Process_Stop
if %STATUS_SERVICE%==RUNNING goto SHUTDOWN_SERVICE
if %STATUS_SERVICE%==STOPPED goto Engine
if %STATUS_SERVICE%==NOT_FOUND goto Engine

:SHUTDOWN_SERVICE
echo mid
sc config DoSvc start=disabled
net stop DoSvc
rem for /f "tokens=7" %%b in ('net stop DoSvc ^| findstr service') do set RESULT_ATOWU=%%b
goto CHECK

:PROCESS_START
echo mid
sc config DoSvc start=auto
net start DoSvc
rem for /f "tokens=7" %%b in ('net start DoSvc ^| findstr service') do set RESULT_ATOWU=%%b
goto CHECK_START

:Engine_Process_Start
set PID_MICROSOFT_CLICKTORUN_SERVICE=NOT_FOUND
for /f "tokens=2" %%b in ('tasklist ^| findstr notepad.exe') do set PID_MICROSOFT_CLICKTORUN_SERVICE=%%b
if %PID_MICROSOFT_CLICKTORUN_SERVICE%==NOT_FOUND (
    goto Engine
) else (
    goto Engine_Process_Start
)

:CHECK_START
echo check
if %RESULT_ATOWU%==Please (
    echo being used
    goto CHECK
) else (
    echo not being used
    goto CHECK_SERVICE_STATE_START
)

:CHECK_SERVICE_STATE_START
echo last
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUS_SERVICE_IN_ENGINE=%%b
if %STATUS_SERVICE_IN_ENGINE%==RUNNING (
    echo Failed
    goto Engine_Process_Start
)
if %STATUS_SERVICE_IN_ENGINE%==STOPPED (
    echo Success
    goto Engine_Process_Start
)
if %STATUS_SERVICE_IN_ENGINE%==NOT_FOUND (
    echo NULL Code:1
    goto Engine_Process_Start
)


:CHECK
echo check
if %RESULT_ATOWU%==Please (
    echo being used
    goto CHECK
) else (
    echo not being used
    goto CHECK_SERVICE_STATE
)

:CHECK_SERVICE_STATE
echo last
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUS_SERVICE_IN_ENGINE=%%b
if %STATUS_SERVICE_IN_ENGINE%==RUNNING (
    echo Running
    goto Somewhere_else
)
if %STATUS_SERVICE_IN_ENGINE%==STOPPED (
    echo Stopped
    goto Somewhere_else
)
if %STATUS_SERVICE_IN_ENGINE%==NOT_FOUND (
    echo NULL Code:1
    goto Somewhere_else
)

:Somewhere_else
goto Engine
echo Execution Success, time : %time%
echo --------END_SCRIPT--------
pause>NUL