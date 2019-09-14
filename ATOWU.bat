::ATOWU v1.0-engine_v2.19p1

::ChangeLog
::Update Engine v2.16p1 Improved Engine and Logs
::Update Engine v2.16p2 Removed Message "Grabbing Status Service"
::Update Engine v2.16p3 Pre-Released App Causing Microsoft Stop Services and taskkill command is Disabled (if the Services stopped Microsoft Office Cannot Run)
::Update Engine v2.17p1b Added Debug mode & improved Engine
::Update Engine v2.19p1b Improved Engine

::README
::ATOWU Works in Windows 7 (TESTED), Windows 8 (UNTESTED), Windows 10 (TESTED)
::ATOWU can Run in Background or Foreground
::ATOWU using 5%-15%+ CPU Because its Realtime Scanning Service and Tasklist 


@echo off
set DATE_MODIFIED=NOT_FOUND
if not exist "%temp%\ATOWU" md %temp%\ATOWU
set DEBUGMODE=NOT_FOUND
for /f "tokens=2" %%b in ('echo %date%') do set DATE_MODIFIED=%%b
if %DATE_MODIFIED%==NOT_FOUND (
    for /f "tokens=1" %%b in ('echo %date%') do set DATE_MODIFIED=%%b
)
if %DATE_MODIFIED%==NOT_FOUND (
    for /f "tokens=3" %%b in ('echo %date%') do set DATE_MODIFIED=%%b
)
if %DATE_MODIFIED%==NOT_FOUND (
    for /f "tokens=4" %%b in ('echo %date%') do set DATE_MODIFIED=%%b
)
if %DATE_MODIFIED%==NOT_FOUND (
    for /f "tokens=5" %%b in ('echo %date%') do set DATE_MODIFIED=%%b
)
echo ATOWU Start Date : %DATE_MODIFIED%
echo ATOWU Start Date : %DATE_MODIFIED% >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
echo [%time%] [Status:Preparing] Starting ATOWU...
echo [%time%] [Status:Preparing] Starting ATOWU... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log

::Checking if Less Mode is On
if exist "%temp%\ATOWU.Less-mode" (
    set LESS_MODE=1
    del /Q %temp%\ATOWU.Less-mode
    echo [%time%] [Status:Less Mode Turned On] ATOWU Running in Less Mode
    echo [%time%] [Status:Less Mode Turned On] ATOWU Running in Less Mode >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
) else (
    set LESS_MODE=0
)
::Checking if Debug Mode is ON
if exist "%temp%\ATOWU.DEBUG" (
    set DEBUGMODE=1
    del /Q %temp%\ATOWU.DEBUG
    set DEBUGMESSAGE= "DEBUG_MODE" 
    set DEBUG_DIR_LOG=[DEBUG]
    echo [%time%] [Status:Debugging...] ATOWU Running in : Debug Mode 
    echo [%time%] [Status:Debugging...] ATOWU Running in : Debug Mode >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto PREPARING_ATOWU
) else (
    set DEBUGMODE=0
)
sc config bits start= disabled>NUL
if errorlevel 1 goto error
:PREPARING_ATOWU
if exist "%temp%\ATOWU\ATOWU_run_in_background" (
    del %temp%\ATOWU\ATOWU_run_in_background
    echo [%time%] [Status:Preparing]%DEBUGMESSAGE% ATOWU running in Background >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    echo [%time%] [Status:Preparing]%DEBUGMESSAGE% ATOWU running in Background
    goto Engine_Log
) else (
    echo [%time%] [Status:Preparing]%DEBUGMESSAGE% ATOWU running in Foreground >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    echo [%time%] [Status:Preparing]%DEBUGMESSAGE% ATOWU running in Foreground
    goto Engine_Log
)

:error
echo [%time%] [Status:Failed_to_Start] ATOWU is failed to start, maybe not running as Administrator ?
echo [%time%] [Status:Failed_to_Start] ATOWU is failed to start, maybe not running as Administrator ? >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log 
@echo result = MsgBox ("Please Run as Administrator, to Start the Process", _  > %temp%\thanks.vbs
@echo   vbOkOnly+vbOkOnly+vbCritical, "Error") >> %temp%\thanks.vbs
@echo Dim message >> %temp%\thanks.vbs
if exist "%temp%\thanks.vbs" goto START_ERROR_MESSAGE_ATOWUENGINE
goto error

:START_ERROR_MESSAGE_ATOWUENGINE
start %temp%\thanks.vbs
timeout 2 /nobreak>NUL
del %temp%\thanks.vbs
exit

:Engine_Log
::Finding OS Type 
for /f "tokens=3,4,5,6" %%b in ('systeminfo ^| findstr Windows') do echo %%b %%c %%d %%e >> %temp%\ATOWU_WINDOWS_VER.txt
for /f "tokens=2" %%b in ('type %temp%\ATOWU_WINDOWS_VER.txt ^| findstr Microsoft') do set OS_TYPE=%%b
for /f "tokens=3" %%b in ('type %temp%\ATOWU_WINDOWS_VER.txt ^| findstr Microsoft') do set VER_OS=%%b
for /f "tokens=4" %%b in ('type %temp%\ATOWU_WINDOWS_VER.txt ^| findstr Microsoft') do set TYPE_OS=%%b
del %temp%\ATOWU_WINDOWS_VER.txt
echo [%time%] [Status:Preparing]%DEBUGMESSAGE% ATOWU Running on : %OS_TYPE% %VER_OS% %TYPE_OS% >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
echo [%time%] [Status:Preparing]%DEBUGMESSAGE% ATOWU Running on : %OS_TYPE% %VER_OS% %TYPE_OS%
echo [%time%] [Status:Running]%DEBUGMESSAGE% SUCCESS!! ATOWU is Running, time start : %time%
echo [%time%] [Status:Running]%DEBUGMESSAGE% SUCCESS!! ATOWU is Running, time start : %time% >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto Engine_FOR_FIRST_STARTUP

:Engine_FOR_FIRST_STARTUP
@title ATOWU v1.0-engine_v2.19p1b%DEBUGMESSAGE%
set PIDWINDOWSDEFENDUPDATE=NOT_FOUND
set PIDOFFICEC2R=NOT_FOUND
set STATUSCLICKTORUNSVC=NOT_FOUND
set STATUSDOSVC=NOT_FOUND
set STATUSBITS=NOT_FOUND
set STATUSWUAUSERV=NOT_FOUND
::Grabbing Status Service
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUSBITS=%%b
for /f "tokens=4" %%b in ('sc query wuauserv ^| findstr STATE') do set STATUSWUAUSERV=%%b
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUSDOSVC=%%b
for /f "tokens=4" %%b in ('sc query ClickToRunSvc ^| findstr STATE') do set STATUSCLICKTORUNSVC=%%b
for /f "tokens=2" %%b in ('tasklist ^| findstr MpCmdRun.exe') do set PIDWINDOWSDEFENDUPDATE=%%b
if %STATUSBITS%==NOT_FOUND (
    echo [%time%] [Status:NOT_FOUND ?] [Service] Background Windows Update Service is Not Found, is it removed ? 
    echo [%time%] [Status:NOT_FOUND ?] [Service] Background Windows Update Service is Not Found, is it removed ? >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto Engine
)
if %STATUSWUAUSERV%==NOT_FOUND (
    echo [%time%] [Status:NOT_FOUND ?] [Service] Windows Update Service is Not Found, is it removed ? 
    echo [%time%] [Status:NOT_FOUND ?] [Service] Windows Update Service is Not Found, is it removed ? >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto Engine
)
if %STATUSDOSVC%==NOT_FOUND (
    echo [%time%] [Status:NOT_FOUND ?] [Service] Delivery Optimization Service is Not Found, is it removed ? 
    echo [%time%] [Status:NOT_FOUND ?] [Service] Delivery Optimization Service is Not Found, is it removed ? >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto Engine
)
goto Engine

::This Label for Grabbing PID App/Status Service
::if each VARIABLE didn't found PID App/Status Service, it will RETURN --> "NOT_FOUND"
::For Example |
::            |
::            V
rem SET PID_UNEXIST_APP=NOT_FOUND
rem for /f "tokens=2" %%b in ('tasklist ^| findstr UnExistApp.exe') do set PID_UNEXIST_APP=%%b
rem and you can see the result by typing "echo %PID_UNEXIST_APP%"
::This always repeat again and again... (unless you change the script :P )
:Engine
if %LESS_MODE%==1 goto Engine_Less_Mode
set PIDWINDOWSDEFENDUPDATE=NOT_FOUND
set PIDOFFICEC2R=NOT_FOUND
set STATUSCLICKTORUNSVC=NOT_FOUND
set STATUSDOSVC=NOT_FOUND
set STATUSBITS=NOT_FOUND
set STATUSWUAUSERV=NOT_FOUND
set SERVICE_IS_ON_WORK=NOT_FOUND
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUSBITS=%%b
for /f "tokens=4" %%b in ('sc query wuauserv ^| findstr STATE') do set STATUSWUAUSERV=%%b
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUSDOSVC=%%b
for /f "tokens=4" %%b in ('sc query ClickToRunSvc ^| findstr STATE') do set STATUSCLICKTORUNSVC=%%b
for /f "tokens=2" %%b in ('tasklist ^| findstr MpCmdRun.exe') do set PIDWINDOWSDEFENDUPDATE=%%b
goto BITS_SERVICE

:Engine_Less_Mode
::Engine in Less Mode
set PIDWINDOWSDEFENDUPDATE=NOT_FOUND
set PIDOFFICEC2R=NOT_FOUND
set STATUSCLICKTORUNSVC=NOT_FOUND
set STATUSDOSVC=NOT_FOUND
set STATUSBITS=NOT_FOUND
set STATUSWUAUSERV=NOT_FOUND
set SERVICE_IS_ON_WORK=NOT_FOUND
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUSBITS=%%b
for /f "tokens=4" %%b in ('sc query wuauserv ^| findstr STATE') do set STATUSWUAUSERV=%%b
timeout 1 /nobreak>NUL
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUSDOSVC=%%b
for /f "tokens=4" %%b in ('sc query ClickToRunSvc ^| findstr STATE') do set STATUSCLICKTORUNSVC=%%b
timeout 1 /nobreak>NUL
for /f "tokens=2" %%b in ('tasklist ^| findstr MpCmdRun.exe') do set PIDWINDOWSDEFENDUPDATE=%%b

::Process ATOWU Engine
goto BITS_SERVICE

:BITS_SERVICE
if %DEBUGMODE%==1 (
    echo BITS_SERVICE Label
)
if %STATUSBITS%==RUNNING goto PROCESS_BITS_SERVICE
if %STATUSBITS%==STOPPED goto WUAUSERV_SERVICE

:PROCESS_BITS_SERVICE
if %DEBUGMODE%==1 (
    echo PROCESS_BITS_SERVICE Label
    echo Result Variable STATUSBITS = %STATUSBITS%
)
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Background Windows Update is Running, trying to shutting down...
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Background Windows Update is Running, trying to shutting down... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto BITS_PROCESS

:BITS_PROCESS_DEBUG
echo BITS_PROCESS_DEBUG Label
set BITS_PROCESS_DEBUG=NOT_FOUND
echo Result Variable BITS_PROCESS_DEBUG (Before) = %BITS_PROCESS_DEBUG%
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set BITS_PROCESS_DEBUG=%%b
echo Result Variable BITS_PROCESS_DEBUG (After) = %BITS_PROCESS_DEBUG%
echo Result Variable RESULT_ATOWU_BITS = %RESULT_ATOWU_BITS%
if %RESULT_ATOWU_BITS%==Please (
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_BITS
) else (
    goto CHECK_SERVICE_BITS
)

:BITS_PROCESS
if %DEBUGMODE%==1 (
    echo BITS_PROCESS Label
)
set RESULT_ATOWU_BITS=NOT_FOUND
sc config bits start= disabled>NUL
::Added Queued Feature, if Services is starting or stopping ATOWU will hold until its done
for /f "tokens=7" %%b in ('net stop bits ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %DEBUGMODE%==1 goto BITS_PROCESS_DEBUG
if %RESULT_ATOWU_BITS%==Please (
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_BITS
) else (
    goto CHECK_SERVICE_BITS
)

:CHECK_TWICE_BITS
if %DEBUGMODE%==1 (
    echo CHECK_TWICE_BITS Label
)
for /f "tokens=7" %%b in ('net stop bits ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %RESULT_ATOWU_BITS%==Please (
    goto CHECK_TWICE_BITS
) else (
    goto CHECK_SERVICE_BITS
)

:CHECK_SERVICE_BITS
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUS_BITS_IN_ENGINE=%%b
if %DEBUGMODE%==1 (
    echo CHECK_SERVICE_BITS Label
    echo Result Variable STATUS_BITS_IN_ENGINE = %STATUS_BITS_IN_ENGINE%
)
if %STATUS_BITS_IN_ENGINE%==RUNNING goto BITS_ERROR
if %STATUS_BITS_IN_ENGINE%==STOPPED goto BITS_PRINT_MESSAGE_AND_OUT

:BITS_PRINT_MESSAGE_AND_OUT
if %DEBUGMODE%==1 (
    echo BITS_PRINT_MESSAGE_AND_OUT Label
)
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto WUAUSERV_SERVICE

:BITS_ERROR
if %DEBUGMODE%==1 (
    echo BITS_ERROR Label
)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:1)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:1) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config bits start= disabled>NUL
set RESULT_ATOWU_BITS=NOT_FOUND
for /f "tokens=7" %%b in ('net stop bits ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %RESULT_ATOWU_BITS%==Please (
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_BITS_ERROR_ATTEMPT_1
) else (
    goto CHECK_SERVICE_BITS_ERROR_ATTEMPT_1
)

:CHECK_TWICE_BITS_ERROR_ATTEMPT_1
if %DEBUGMODE%==1 (
    echo CHECK_TWICE_BITS_ERROR_ATTEMPT_1 Label
)
for /f "tokens=7" %%b in ('net stop bits ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %RESULT_ATOWU_BITS%==Please (
    goto CHECK_TWICE_BITS_ERROR_ATTEMPT_1
) else (
    goto CHECK_SERVICE_BITS_ERROR_ATTEMPT_1
)

:CHECK_SERVICE_BITS_ERROR_ATTEMPT_1
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUS_BITS_IN_ENGINE=%%b
if %DEBUGMODE%==1 (
    echo Result Variable STATUS_BITS_IN_ENGINE = %STATUS_BITS_IN_ENGINE%
)
if %STATUS_BITS_IN_ENGINE%==RUNNING goto BITS_ERROR_ATTEMPT_2
if %STATUS_BITS_IN_ENGINE%==STOPPED goto BITS_PRINT_MESSAGE_AND_OUT

:BITS_ERROR_ATTEMPT_2
if %DEBUGMODE%==1 (
    echo BITS_ERROR_ATTEMPT_2 Label
)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:2)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:2) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config bits start= disabled>NUL
set RESULT_ATOWU_BITS=NOT_FOUND
for /f "tokens=7" %%b in ('net stop bits ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %RESULT_ATOWU_BITS%==Please (
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_BITS_ERROR_ATTEMPT_2
) else (
    goto CHECK_SERVICE_BITS_ERROR_ATTEMPT_2
)

:CHECK_TWICE_BITS_ERROR_ATTEMPT_2
if %DEBUGMODE%==1 (
    echo CHECK_TWICE_BITS_ERROR_ATTEMPT_2 Label
)
for /f "tokens=7" %%b in ('net stop bits ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %RESULT_ATOWU_BITS%==Please (
    goto CHECK_TWICE_BITS_ERROR_ATTEMPT_2
) else (
    goto CHECK_SERVICE_BITS_ERROR_ATTEMPT_2
)

:CHECK_SERVICE_BITS_ERROR_ATTEMPT_2
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUS_BITS_IN_ENGINE=%%b
if %DEBUGMODE%==1 (
    echo Result Variable STATUS_BITS_IN_ENGINE = %STATUS_BITS_IN_ENGINE%
)
if %STATUS_BITS_IN_ENGINE%==RUNNING goto BITS_ERROR_ATTEMPT_3
if %STATUS_BITS_IN_ENGINE%==STOPPED goto BITS_PRINT_MESSAGE_AND_OUT

:BITS_ERROR_ATTEMPT_3
if %DEBUGMODE%==1 (
    echo BITS_ERROR_ATTEMPT_3 Label
)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:3)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:3) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config bits start= disabled>NUL
set RESULT_ATOWU_BITS=NOT_FOUND
for /f "tokens=7" %%b in ('net stop bits ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %RESULT_ATOWU_BITS%==Please (
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_BITS_ERROR_ATTEMPT_3
) else (
    goto CHECK_SERVICE_BITS_ERROR_ATTEMPT_3
)

:CHECK_TWICE_BITS_ERROR_ATTEMPT_3
if %DEBUGMODE%==1 (
    echo CHECK_TWICE_BITS_ERROR_ATTEMPT_3 Label
)
for /f "tokens=7" %%b in ('net stop bits ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %RESULT_ATOWU_BITS%==Please (
    goto CHECK_TWICE_BITS_ERROR_ATTEMPT_3
) else (
    goto CHECK_SERVICE_BITS_ERROR_ATTEMPT_3
)

:CHECK_SERVICE_BITS_ERROR_ATTEMPT_3
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUS_BITS_IN_ENGINE=%%b
if %DEBUGMODE%==1 (
    echo Result Variable STATUS_BITS_IN_ENGINE = %STATUS_BITS_IN_ENGINE%
)
if %STATUS_BITS_IN_ENGINE%==RUNNING goto BITS_ERROR_LAST_ATTEMPT
if %STATUS_BITS_IN_ENGINE%==STOPPED goto BITS_PRINT_MESSAGE_AND_OUT

:BITS_ERROR_LAST_ATTEMPT
if %DEBUGMODE%==1 (
    echo BITS_ERROR_LAST_ATTEMPT Label
)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% too many Attempts to Shutting down Background Windows Update, Skip to next Task...
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% too many Attempts to Shutting down Background Windows Update, Skip to next Task... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto WUAUSERV_SERVICE

:WUAUSERV_SERVICE
if %DEBUGMODE%==1 (
    echo WUAUSERV_SERVICE Label
)
if %STATUSWUAUSERV%==STOPPED goto DOSVC_SERVICE
if %STATUSWUAUSERV%==RUNNING goto PROCESS_WUAUSERV_SERVICE

:PROCESS_WUAUSERV_SERVICE
if %DEBUGMODE%==1 (
    echo PROCESS_WUAUSERV_SERVICE Label
    echo Result Variable STATUSWUAUSERV = %STATUSWUAUSERV%
)
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Windows Update is Running, trying to shutting down...
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Windows Update is Running, trying to shutting down... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto WUAUSERV_PROCESS

:WUAUSERV_PROCESS_DEBUG
echo WUAUSERV_PROCESS_DEBUG Label
set WUAUSERV_PROCESS_DEBUG=NOT_FOUND
echo Result Variable WUAUSERV_PROCESS_DEBUG (Before) = %WUAUSERV_PROCESS_DEBUG%
for /f "tokens=4" %%b in ('sc query WUAUSERV ^| findstr STATE') do set WUAUSERV_PROCESS_DEBUG=%%b
echo Result Variable WUAUSERV_PROCESS_DEBUG (After) = %WUAUSERV_PROCESS_DEBUG%
echo Result Variable RESULT_ATOWU_WINDOWS_UPDATE = %RESULT_ATOWU_WINDOWS_UPDATE%
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_WUAUSERV
) else (
    goto CHECK_SERVICE_WUAUSERV
)

:WUAUSERV_PROCESS
if %DEBUGMODE%==1 (
    echo WUAUSERV_PROCESS Label
)
sc config wuauserv start= disabled>NUL
set RESULT_ATOWU_WINDOWS_UPDATE=NOT_FOUND
for /f "tokens=7" %%b in ('net stop wuauserv ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %DEBUGMODE%==1 goto WUAUSERV_PROCESS_DEBUG
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_WUAUSERV
) else (
    goto CHECK_SERVICE_WUAUSERV
)

:CHECK_TWICE_WUAUSERV
if %DEBUGMODE%==1 (
    echo CHECK_TWICE_WUAUSERV Label
)
for /f "tokens=7" %%b in ('net stop wuauserv ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    goto CHECK_TWICE_WUAUSERV
) else (
    goto CHECK_SERVICE_WUAUSERV
)

:CHECK_SERVICE_WUAUSERV
for /f "tokens=4" %%b in ('sc query wuauserv ^| findstr STATE') do set STATUS_WUAUSERV_IN_ENGINE=%%b
if %DEBUGMODE%==1 (
    echo CHECK_SERVICE_WUAUSERV Label
    echo Result Variable STATUS_WUAUSERV_IN_ENGINE = %STATUS_WUAUSERV_IN_ENGINE%
)
if %STATUS_WUAUSERV_IN_ENGINE%==RUNNING goto WUAUSERV_ERROR
if %STATUS_WUAUSERV_IN_ENGINE%==STOPPED goto WUAUSERV_PRINT_MESSAGE_AND_OUT

:WUAUSERV_PRINT_MESSAGE_AND_OUT
if %DEBUGMODE%==1 (
    echo WUAUSERV_PRINT_MESSAGE_AND_OUT Label
)
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto DOSVC_SERVICE

:WUAUSERV_ERROR
if %DEBUGMODE%==1 (
    echo WUAUSERV_ERROR Label
)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:1)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:1) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config wuauserv start= disabled>NUL
for /f "tokens=7" %%b in ('net stop wuauserv ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_1
) else (
    goto CHECK_SERVICE_WUAUSERV_ERROR_ATTEMPT_1
)

:CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_1
if %DEBUGMODE%==1 (
    echo CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_1 Label
)
for /f "tokens=7" %%b in ('net stop WUAUSERV ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    goto CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_1
) else (
    goto CHECK_SERVICE_WUAUSERV_ERROR_ATTEMPT_1
)

:CHECK_SERVICE_WUAUSERV_ERROR_ATTEMPT_1
for /f "tokens=4" %%b in ('sc query WUAUSERV ^| findstr STATE') do set STATUS_WUAUSERV_IN_ENGINE=%%b
if %DEBUGMODE%==1 (
    echo Result Variable STATUS_WUAUSERV_IN_ENGINE = %STATUS_WUAUSERV_IN_ENGINE%
)
if %STATUS_WUAUSERV_IN_ENGINE%==RUNNING goto WUAUSERV_ERROR_ATTEMPT_2
if %STATUS_WUAUSERV_IN_ENGINE%==STOPPED goto WUAUSERV_PRINT_MESSAGE_AND_OUT

:WUAUSERV_ERROR_ATTEMPT_2
if %DEBUGMODE%==1 (
    echo WUAUSERV_ERROR_ATTEMPT_2 Label
)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:1)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:1) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config WUAUSERV start= disabled>NUL
set RESULT_ATOWU_WUAUSERV=NOT_FOUND
for /f "tokens=7" %%b in ('net stop WUAUSERV ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_2
) else (
    goto CHECK_SERVICE_WUAUSERV_ERROR_ATTEMPT_2
)

:CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_2
if %DEBUGMODE%==1 (
    echo CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_2 Label
)
for /f "tokens=7" %%b in ('net stop WUAUSERV ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    goto CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_2
) else (
    goto CHECK_SERVICE_WUAUSERV_ERROR_ATTEMPT_2
)

:CHECK_SERVICE_WUAUSERV_ERROR_ATTEMPT_2
for /f "tokens=4" %%b in ('sc query WUAUSERV ^| findstr STATE') do set STATUS_WUAUSERV_IN_ENGINE=%%b
if %DEBUGMODE%==1 (
    echo Result Variable STATUS_WUAUSERV_IN_ENGINE = %STATUS_WUAUSERV_IN_ENGINE%
)
if %STATUS_WUAUSERV_IN_ENGINE%==RUNNING goto WUAUSERV_ERROR_ATTEMPT_3
if %STATUS_WUAUSERV_IN_ENGINE%==STOPPED goto WUAUSERV_PRINT_MESSAGE_AND_OUT

:WUAUSERV_ERROR_ATTEMPT_3
if %DEBUGMODE%==1 (
    echo WUAUSERV_ERROR_ATTEMPT_3 Label
)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:1)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:1) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config WUAUSERV start= disabled>NUL
set RESULT_ATOWU_WUAUSERV=NOT_FOUND
for /f "tokens=7" %%b in ('net stop WUAUSERV ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_3
) else (
    goto CHECK_SERVICE_WUAUSERV_ERROR_ATTEMPT_3
)

:CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_3
if %DEBUGMODE%==1 (
    echo CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_3 Label
)
for /f "tokens=7" %%b in ('net stop WUAUSERV ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    goto CHECK_TWICE_WUAUSERV_ERROR_ATTEMPT_3
) else (
    goto CHECK_SERVICE_WUAUSERV_ERROR_ATTEMPT_3
)

:CHECK_SERVICE_WUAUSERV_ERROR_ATTEMPT_3
for /f "tokens=4" %%b in ('sc query WUAUSERV ^| findstr STATE') do set STATUS_WUAUSERV_IN_ENGINE=%%b
if %DEBUGMODE%==1 (
    echo Result Variable STATUS_WUAUSERV_IN_ENGINE = %STATUS_WUAUSERV_IN_ENGINE%
)
if %STATUS_WUAUSERV_IN_ENGINE%==RUNNING goto WUAUSERV_ERROR_LAST_ATTEMPT
if %STATUS_WUAUSERV_IN_ENGINE%==STOPPED goto WUAUSERV_PRINT_MESSAGE_AND_OUT

:WUAUSERV_ERROR_LAST_ATTEMPT
if %DEBUGMODE%==1 (
    echo WUAUSERV_ERROR_LAST_ATTEMPT Label
)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% too many Attempts to Shutting down Windows Update, Skip to next Task...
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% too many Attempts to Shutting down Windows Update, Skip to next Task... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto DOSVC_SERVICE

:DOSVC_SERVICE
if %DEBUGMODE%==1 (
    echo DOSVC_SERVICE IF COMMAND
)
if %STATUSDOSVC%==NOT_FOUND goto WINDOWSDEFEND_UPDATE_KILLPROCESS
if %STATUSDOSVC%==STOPPED goto WINDOWSDEFEND_UPDATE_KILLPROCESS
if %STATUSDOSVC%==RUNNING goto PROCESS_DOSVC_SERVICE

:PROCESS_DOSVC_SERVICE
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Delivery Optimization is Running, trying to shutting down...
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Delivery Optimization is Running, trying to shutting down... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto DOSVC_PROCESS

:DOSVC_PROCESS
sc config DoSvc start= disabled>NUL
set RESULT_ATOWU_DOSVC=NOT_FOUND
for /f "tokens=7" %%b in ('net stop DoSvc ^| findstr service') do set RESULT_ATOWU_DOSVC=%%b
if %RESULT_ATOWU_DOSVC%==Please (
    echo [%time%] [Status:QUEUED] [Service] Delivery Optimization is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Delivery Optimization is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_DOSVC
) else (
    goto CHECK_SERVICE_DOSVC
)

:CHECK_TWICE_DOSVC
for /f "tokens=7" %%b in ('net stop DoSvc ^| findstr service') do set RESULT_ATOWU_DOSVC=%%b
if %RESULT_ATOWU_DOSVC%==Please (
    goto CHECK_TWICE_DOSVC
) else (
    goto CHECK_SERVICE_DOSVC
)

:CHECK_SERVICE_DOSVC
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUS_DOSVC_IN_ENGINE=%%b
if %STATUS_DOSVC_IN_ENGINE%==RUNNING goto DOSVC_ERROR
if %STATUS_DOSVC_IN_ENGINE%==STOPPED goto DOSVC_PRINT_MESSAGE_AND_OUT


:DOSVC_PRINT_MESSAGE_AND_OUT
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Delivery Optimization Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Delivery Optimization Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto WINDOWSDEFEND_UPDATE_KILLPROCESS

:DOSVC_ERROR
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Delivery Optimization Failed to Shut Down, trying again... (Attempt:1)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Delivery Optimization Failed to Shut Down, trying again... (Attempt:1) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config DoSvc start= disabled
net stop DoSvc
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUS_DOSVC_IN_ENGINE=%%b
if %STATUS_DOSVC_IN_ENGINE%==RUNNING goto DOSVC_ERROR_ATTEMPT_2
if %STATUS_DOSVC_IN_ENGINE%==STOPPED goto DOSVC_PRINT_MESSAGE_AND_OUT

:DOSVC_ERROR_ATTEMPT_2
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Delivery Optimization Failed to Shut Down, trying again... (Attempt:2)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Delivery Optimization Failed to Shut Down, trying again... (Attempt:2) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config DoSvc start= disabled
net stop DoSvc
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUS_DOSVC_IN_ENGINE=%%b
if %STATUS_DOSVC_IN_ENGINE%==RUNNING goto DOSVC_ERROR_ATTEMPT_3
if %STATUS_DOSVC_IN_ENGINE%==STOPPED goto DOSVC_PRINT_MESSAGE_AND_OUT

:DOSVC_ERROR_ATTEMPT_3
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Delivery Optimization Failed to Shut Down, trying again... (Attempt:3)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Delivery Optimization Failed to Shut Down, trying again... (Attempt:3) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config DoSvc start= disabled
net stop DoSvc
for /f "tokens=4" %%b in ('sc query DoSvc ^| findstr STATE') do set STATUS_DOSVC_IN_ENGINE=%%b
if %STATUS_DOSVC_IN_ENGINE%==RUNNING goto DOSVC_ERROR_LAST_ATTEMPT
if %STATUS_DOSVC_IN_ENGINE%==STOPPED goto DOSVC_PRINT_MESSAGE_AND_OUT

:DOSVC_ERROR_LAST_ATTEMPT
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% too many Attempts to Shutting down Delivery Optimization, Skip to next Task...
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% too many Attempts to Shutting down Delivery Optimization, Skip to next Task... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto WINDOWSDEFEND_UPDATE_KILLPROCESS

:WINDOWSDEFEND_UPDATE_KILLPROCESS
if %DEBUGMODE%==1 (
    echo WindowsDefend Update KillProcess IF COMMAND
)
if %PIDWINDOWSDEFENDUPDATE%==NOT_FOUND goto Engine
echo [%time%] [Status:FOUND!!!] [App] WindowsDefend Update is Running, trying to shutting down...
echo [%time%] [Status:FOUND!!!] [App] WindowsDefend Update is Running, trying to shutting down... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
taskkill /PID %PIDWINDOWSDEFENDUPDATE% /f /T
if errorlevel 1 goto WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_1
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
if %LESS_MODE%==1 (
    timeout 3 /nobreak>NUL
    goto Engine_Less_Mode
) else (
    timeout 1 /nobreak>NUL
    goto Engine
)


:WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_1
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:1)
echo [%time%] [Status:Failed_Shutting_down] [App] Windows Defender Update Failed to Shut Down, trying again... (Attempt:1) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
taskkill /PID %PIDWINDOWSDEFENDUPDATE% /f /T
if errorlevel 1 goto WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_2
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
if %LESS_MODE%==1 (
    timeout 3 /nobreak>NUL
    goto Engine_Less_Mode
) else (
    timeout 1 /nobreak>NUL
    goto Engine
)


:WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_2
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:2)
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:2) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
taskkill /PID %PIDWINDOWSDEFENDUPDATE% /f /T
if errorlevel 1 goto WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_3
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
if %LESS_MODE%==1 (
    timeout 3 /nobreak>NUL
    goto Engine_Less_Mode
) else (
    timeout 1 /nobreak>NUL
    goto Engine
)


:WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_3
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:3)
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:3) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
taskkill /PID %PIDWINDOWSDEFENDUPDATE% /f /T
if errorlevel 1 goto WINDOWSDEFEND_UPDATE_KILLPROCESS_LAST_ATTEMPT
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
if %LESS_MODE%==1 (
    timeout 3 /nobreak>NUL
    goto Engine_Less_Mode
) else (
    timeout 1 /nobreak>NUL
    goto Engine
)


:WINDOWSDEFEND_UPDATE_KILLPROCESS_LAST_ATTEMPT
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% too many Attempts to Shutting down Windows Defender Update, Skip to next Task...
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% too many Attempts to Shutting down Windows Defender Update, Skip to next Task... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
if %LESS_MODE%==1 (
    timeout 3 /nobreak>NUL
    goto Engine_Less_Mode
) else (
    timeout 1 /nobreak>NUL
    goto Engine
)


