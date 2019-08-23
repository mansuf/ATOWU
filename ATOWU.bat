::ATOWU v1.0-engine_v2.18p1

::ChangeLog
::Update Engine v2.16p1 Improved Engine and Logs
::Update Engine v2.16p2 Removed Message "Grabbing Status Service"
::Update Engine v2.16p3 Pre-Released App Causing Microsoft Stop Services and taskkill command is Disabled (if the Services stopped Microsoft Office Cannot Run)
::Update Engine v2.17p1b Added Debug mode & improved Engine
::[ON PROGRESS]Update Engine v2.19p1b Improved Engine

::README
::ATOWU Works in Windows 7 (TESTED), Windows 8 (UNTESTED), Windows 10 (TESTED)
::ATOWU can Run in Background or Foreground
::ATOWU using 7%-11%+ CPU Because its Realtime Scanning Service and Tasklist 


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
::Checking if Debug Mode is ON
if exist "%temp%\ATOWU.DEBUG" (
    set DEBUGMODE=1
    del %temp%\ATOWU.DEBUG
    set DEBUGMESSAGE= "DEBUG_MODE" 
    set DEBUG_DIR_LOG=[DEBUG]
    echo [%time%] [Status:Debugging...] ATOWU Running in : Debug Mode 
    echo [%time%] [Status:Debugging...] ATOWU Running in : Debug Mode >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto PREPARING_ATOWU
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
@title ATOWU v1.0-engine_v2.18p1%DEBUGMESSAGE%
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
rem for /f "tokens=2" %%b in ('tasklist ^| findstr OfficeClickToRun.exe') do set PIDOFFICEC2R=%%b
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
rem if %STATUSCLICKTORUNSVC%==NOT_FOUND (
    rem echo [%time%] [Status:NOT_FOUND ?] [Service] Microsoft ClickToRun Service is Not Found, is it removed ? 
    rem echo [%time%] [Status:NOT_FOUND ?] [Service] Microsoft ClickToRun Service is Not Found, is it removed ? >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    rem goto Engine
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
rem for /f "tokens=2" %%b in ('tasklist ^| findstr OfficeClickToRun.exe') do set PIDOFFICEC2R=%%b
goto BITS_SERVICE


::Process ATOWU Engine
goto BITS_SERVICE

:BITS_SERVICE
if %DEBUGMODE%==1 (
    echo BITS_SERVICE IF COMMAND
)
if %STATUSBITS%==RUNNING goto PROCESS_BITS_SERVICE
if %STATUSBITS%==STOPPED goto WUAUSERV_SERVICE

:PROCESS_BITS_SERVICE
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Background Windows Update is Running, trying to shutting down...
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Background Windows Update is Running, trying to shutting down... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto CHECK_SERVICE_IS_ON_WORK_BITS

::If Net Command is being used, ATOWU will hold until Net Command is Unused
:CHECK_SERVICE_IS_ON_WORK_BITS
set SERVICE_IS_ON_WORK=NOT_FOUND
for /f "tokens=2" %%b in ('tasklist ^| findstr net.exe') do set SERVICE_IS_ON_WORK=%%b
if %SERVICE_IS_ON_WORK%==NOT_FOUND (
    goto BITS_PROCESS
) else (
    echo [%time%] [Status:Holded] [Service] Net Command is being used, Please Wait...
    echo [%time%] [Status:Holded] [Service] Net Command is being used, Please Wait... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log 
    goto CHECK_SERVICE_IS_ON_WORK_BITS_2
)

:CHECK_SERVICE_IS_ON_WORK_BITS_2
set SERVICE_IS_ON_WORK=NOT_FOUND
for /f "tokens=2" %%b in ('tasklist ^| findstr net.exe') do set SERVICE_IS_ON_WORK=%%b
if %SERVICE_IS_ON_WORK%==NOT_FOUND (
    goto BITS_PROCESS
) else (
    goto CHECK_SERVICE_IS_ON_WORK_BITS_2
)

:BITS_PROCESS
set RESULT_ATOWU_BITS=NOT_FOUND
sc config bits start= disabled>NUL
for /f "tokens=7" %%b in ('net stop bits ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %RESULT_ATOWU_BITS%==Please (
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_BITS
) else (
    goto CHECK_SERVICE_BITS
)

:CHECK_TWICE_BITS
for /f "tokens=7" %%b in ('net stop wuauserv ^| findstr service') do set RESULT_ATOWU_BITS=%%b
if %RESULT_ATOWU_BITS%==Please (
    goto CHECK_TWICE_BITS
) else (
    goto CHECK_SERVICE_BITS
)

:CHECK_SERVICE_BITS
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUS_BITS_IN_ENGINE=%%b
if %STATUS_BITS_IN_ENGINE%==RUNNING goto BITS_ERROR
if %STATUS_BITS_IN_ENGINE%==STOPPED goto BITS_PRINT_MESSAGE_AND_OUT

:BITS_PRINT_MESSAGE_AND_OUT
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto WUAUSERV_SERVICE

:BITS_ERROR
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:1)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:1) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config bits start= disabled
net stop bits
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUS_BITS_IN_ENGINE=%%b
if %STATUS_BITS_IN_ENGINE%==RUNNING goto BITS_ERROR_ATTEMPT_2
if %STATUS_BITS_IN_ENGINE%==STOPPED goto BITS_PRINT_MESSAGE_AND_OUT

:BITS_ERROR_ATTEMPT_2
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:2)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:2) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config bits start= disabled
net stop bits
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUS_BITS_IN_ENGINE=%%b
if %STATUS_BITS_IN_ENGINE%==RUNNING goto BITS_ERROR_ATTEMPT_3
if %STATUS_BITS_IN_ENGINE%==STOPPED goto BITS_PRINT_MESSAGE_AND_OUT

:BITS_ERROR_ATTEMPT_3
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:3)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Background Windows Update Failed to Shut Down, trying again... (Attempt:3) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config bits start= disabled
net stop bits
for /f "tokens=4" %%b in ('sc query bits ^| findstr STATE') do set STATUS_BITS_IN_ENGINE=%%b
if %STATUS_BITS_IN_ENGINE%==RUNNING goto BITS_ERROR_LAST_ATTEMPT
if %STATUS_BITS_IN_ENGINE%==STOPPED goto BITS_PRINT_MESSAGE_AND_OUT

:BITS_ERROR_LAST_ATTEMPT
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% too many Attempts to Shutting down Background Windows Update, Skip to next Task...
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% too many Attempts to Shutting down Background Windows Update, Skip to next Task... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto WUAUSERV_SERVICE

:WUAUSERV_SERVICE
if %DEBUGMODE%==1 (
    echo WUAUSERV_SERVICE IF COMMAND
)
if %STATUSWUAUSERV%==STOPPED goto DOSVC_SERVICE
if %STATUSWUAUSERV%==RUNNING goto PROCESS_WUAUSERV_SERVICE

:PROCESS_WUAUSERV_SERVICE
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Windows Update is Running, trying to shutting down...
echo [%time%] [Status:FOUND!!!] [Service]%DEBUGMESSAGE% Windows Update is Running, trying to shutting down... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto CHECK_SERVICE_IS_ON_WORK_WUAUSERV

:CHECK_SERVICE_IS_ON_WORK_WUAUSERV
set SERVICE_IS_ON_WORK=NOT_FOUND
for /f "tokens=2" %%b in ('tasklist ^| findstr net.exe') do set SERVICE_IS_ON_WORK=%%b
if %SERVICE_IS_ON_WORK%==NOT_FOUND (
    goto WUAUSERV_PROCESS
) else (
    echo [%time%] [Status:Holded] [Service] Net Command is being used, Please Wait...
    echo [%time%] [Status:Holded] [Service] Net Command is being used, Please Wait... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log 
    goto CHECK_SERVICE_IS_ON_WORK_WUAUSERV_2
)

:CHECK_SERVICE_IS_ON_WORK_WUAUSERV_2
set SERVICE_IS_ON_WORK=NOT_FOUND
for /f "tokens=2" %%b in ('tasklist ^| findstr net.exe') do set SERVICE_IS_ON_WORK=%%b
if %SERVICE_IS_ON_WORK%==NOT_FOUND (
    goto WUAUSERV_PROCESS
) else (
    goto CHECK_SERVICE_IS_ON_WORK_WUAUSERV_2
)

:WUAUSERV_PROCESS
sc config wuauserv start= disabled>NUL
set RESULT_ATOWU_WINDOWS_UPDATE=NOT_FOUND
for /f "tokens=7" %%b in ('net stop wuauserv ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... 
    echo [%time%] [Status:QUEUED] [Service] Windows Update is Starting or Stopping... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
    goto CHECK_TWICE_WUAUSERV
) else (
    goto CHECK_SERVICE_WUAUSERV
)

:CHECK_TWICE_WUAUSERV
for /f "tokens=7" %%b in ('net stop wuauserv ^| findstr service') do set RESULT_ATOWU_WINDOWS_UPDATE=%%b
if %RESULT_ATOWU_WINDOWS_UPDATE%==Please (
    goto CHECK_TWICE_WUAUSERV
) else (
    goto CHECK_SERVICE_WUAUSERV
)

:CHECK_SERVICE_WUAUSERV
for /f "tokens=4" %%b in ('sc query wuauserv ^| findstr STATE') do set STATUS_WUAUSERV_IN_ENGINE=%%b
if %STATUS_WUAUSERV_IN_ENGINE%==RUNNING goto WUAUSERV_ERROR
if %STATUS_WUAUSERV_IN_ENGINE%==STOPPED goto WUAUSERV_PRINT_MESSAGE_AND_OUT

:WUAUSERV_PRINT_MESSAGE_AND_OUT
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto DOSVC_SERVICE

:WUAUSERV_ERROR
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:1)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:1) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config wuauserv start= disabled
net stop wuauserv
for /f "tokens=4" %%b in ('sc query wuauserv ^| findstr STATE') do set STATUS_WUAUSERV_IN_ENGINE=%%b
if %STATUS_WUAUSERV_IN_ENGINE%==RUNNING goto WUAUSERV_ERROR_ATTEMPT_2
if %STATUS_WUAUSERV_IN_ENGINE%==STOPPED goto WUAUSERV_PRINT_MESSAGE_AND_OUT

:WUAUSERV_ERROR_ATTEMPT_2
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:2)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:2) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config wuauserv start= disabled
net stop wuauserv
for /f "tokens=4" %%b in ('sc query wuauserv ^| findstr STATE') do set STATUS_WUAUSERV_IN_ENGINE=%%b
if %STATUS_WUAUSERV_IN_ENGINE%==RUNNING goto WUAUSERV_ERROR_ATTEMPT_3
if %STATUS_WUAUSERV_IN_ENGINE%==STOPPED goto WUAUSERV_PRINT_MESSAGE_AND_OUT

:WUAUSERV_ERROR_ATTEMPT_3
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:3)
echo [%time%] [Status:Failed_Shutting_down] [Service]%DEBUGMESSAGE% Windows Update Failed to Shut Down, trying again... (Attempt:3) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
sc config wuauserv start= disabled
net stop wuauserv
for /f "tokens=4" %%b in ('sc query wuauserv ^| findstr STATE') do set STATUS_WUAUSERV_IN_ENGINE=%%b
if %STATUS_WUAUSERV_IN_ENGINE%==RUNNING goto WUAUSERV_ERROR_LAST_ATTEMPT
if %STATUS_WUAUSERV_IN_ENGINE%==STOPPED goto WUAUSERV_PRINT_MESSAGE_AND_OUT

:WUAUSERV_ERROR_LAST_ATTEMPT
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
goto CHECK_SERVICE_IS_ON_WORK_DOSVC

:CHECK_SERVICE_IS_ON_WORK_DOSVC
set SERVICE_IS_ON_WORK=NOT_FOUND
for /f "tokens=2" %%b in ('tasklist ^| findstr net.exe') do set SERVICE_IS_ON_WORK=%%b
if %SERVICE_IS_ON_WORK%==NOT_FOUND (
    goto DOSVC_PROCESS
) else (
    echo [%time%] [Status:Holded] [Service] Net Command is being used, Please Wait...
    echo [%time%] [Status:Holded] [Service] Net Command is being used, Please Wait... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log 
    goto CHECK_SERVICE_IS_ON_WORK_DOSVC_2
)

:CHECK_SERVICE_IS_ON_WORK_DOSVC_2
set SERVICE_IS_ON_WORK=NOT_FOUND
for /f "tokens=2" %%b in ('tasklist ^| findstr net.exe') do set SERVICE_IS_ON_WORK=%%b
if %SERVICE_IS_ON_WORK%==NOT_FOUND (
    goto DOSVC_PROCESS
) else (
    goto CHECK_SERVICE_IS_ON_WORK_DOSVC_2
)

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
goto Engine

:WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_1
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:1)
echo [%time%] [Status:Failed_Shutting_down] [App] Windows Defender Update Failed to Shut Down, trying again... (Attempt:1) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
taskkill /PID %PIDWINDOWSDEFENDUPDATE% /f /T
if errorlevel 1 goto WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_2
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto Engine

:WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_2
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:2)
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:2) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
taskkill /PID %PIDWINDOWSDEFENDUPDATE% /f /T
if errorlevel 1 goto WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_3
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto Engine

:WINDOWSDEFEND_UPDATE_KILLPROCESS_ATTEMPT_3
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:3)
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Failed to Shut Down, trying again... (Attempt:3) >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
taskkill /PID %PIDWINDOWSDEFENDUPDATE% /f /T
if errorlevel 1 goto WINDOWSDEFEND_UPDATE_KILLPROCESS_LAST_ATTEMPT
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down 
echo [%time%] [Status:Success_Shutting_down] [App]%DEBUGMESSAGE% Windows Defender Update Successfully Shut down >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto Engine

:WINDOWSDEFEND_UPDATE_KILLPROCESS_LAST_ATTEMPT
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% too many Attempts to Shutting down Windows Defender Update, Skip to next Task...
echo [%time%] [Status:Failed_Shutting_down] [App]%DEBUGMESSAGE% too many Attempts to Shutting down Windows Defender Update, Skip to next Task... >> %temp%\ATOWU\%DEBUG_DIR_LOG%ATOWU.log
goto Engine


::--------------------------------------------------------------------END---LINE---SCRIPT---------------------------------------------------------------------------------
