# ATOWU in Python
import os
from os import system
import datetime
from time import sleep

def on_exit():
    exit()

def date():
    global y_read_date
    x = open("date.bat", "w")
    x.write("@echo off\nset DATE_INIT=NOT_FOUND\nfor /f " + '"tokens=2"' + " %%b in ('echo %date%') do set DATE_INIT=%%b\nif %DATE_INIT%==NOT_FOUND for /f " + '"tokens=1"' + " %%b in ('echo %DATE%') do set DATE_INIT=%%b\necho %DATE_INIT% > date.txt")
    x.close()
    system('"date.bat"')
    y = open("date.txt", "r")
    y_read_date = y.readline()
    y.close()
    if os.path.exists("date.bat"):
        os.remove("date.bat")
    if os.path.exists("date.txt"):
        os.remove("date.txt")


def menu_message():
    print("ATOWU Start Date : " + y_read_date.strip())
    x_time = str(datetime.datetime.now().time())
    print("[" + x_time + "]" + " " + "[Status:Preparing] Starting ATOWU...")

def check_less_mode():
    global less_mode
    if os.path.exists("%temp%\\ATOWU.Less-mode"):
        os.remove("%temp%\\ATOWU.Less-mode")
        less_mode = "1"
        x_time = str(datetime.datetime.now().time())
        print("[" + x_time + "]" + " " + "[Status:Less Mode Turned On] ATOWU Running in Less Mode")
    else:
        less_mode = "0"

def check_debug_mode():
    global debugmode
    global debugmessage
    global debug_dir_log
    if os.path.exists("%temp%\\ATOWU.DEBUG"):
        os.remove("%temp%\\ATOWU.DEBUG")
        debugmode = "1"
        debugmessage = '"DEBUG_MODE"'
        debug_dir_log = "[DEBUG]"
    else:
        debugmode = "0"

def check_admin():
    global y_read_check_admin
    x = open("check_admin.bat", "w")
    x.write("@echo off\nsc config bits start= disabled>NUL\nif errorlevel 1 goto ERROR\necho SUCCESS > result_check_admin.txt\nexit\n:ERROR\necho FAILED > result_check_admin.txt\nexit")
    x.close()
    system('"check_admin.bat"')
    y = open("result_check_admin.txt", "r")
    y_read_check_admin = y.read()
    if y_read_check_admin.strip() == "SUCCESS":
        x_time = str(datetime.datetime.now().time())
        print("[" + x_time + "]" + " " + "[Status:Preparing] ATOWU Running as Administrator User")
    else:
        x_time = str(datetime.datetime.now().time())
        print("[" + x_time + "]" + " " + "[Status:Failed_to_Start] ATOWU Running as Local User")
        print("[" + x_time + "]" + " " + "[Status:Failed_to_Start] ATOWU is failed to start, maybe not running as Administrator ?")
        y.close()
        if os.path.exists("check_admin.bat"):
            os.remove("check_admin.bat")
        if os.path.exists("result_check_admin.txt"):
            os.remove("result_check_admin.txt")
        on_exit()
    y.close()
    if os.path.exists("check_admin.bat"):
        os.remove("check_admin.bat")
    if os.path.exists("result_check_admin.txt"):
        os.remove("result_check_admin.txt")
    
def find_OS():
    global y_read_find_OS
    x = open("find_os.bat", "w")
    x.write("@echo off\nfor /f " + '"tokens=3,4,5,6"' " %%b in ('systeminfo ^| findstr Windows') do echo %%b %%c %%d %%e >> %temp%\\ATOWU_WINDOWS_VER.txt\nfor /f " + '"tokens=2"' + " %%b in ('type %temp%\\ATOWU_WINDOWS_VER.txt ^| findstr Microsoft') do set OS_TYPE=%%b" + "\nfor /f " + '"tokens=3"' + " %%b in ('type %temp%\\ATOWU_WINDOWS_VER.txt ^| findstr Microsoft') do set VER_OS=%%b" + "\nfor /f " + '"tokens=4"' + " %%b in ('type %temp%\\ATOWU_WINDOWS_VER.txt ^| findstr Microsoft') do set TYPE_OS=%%b\necho %OS_TYPE% %VER_OS% %TYPE_OS% > result_findOS.txt\nexit")
    x.close()
    system('"find_os.bat"')
    y = open("result_findOS.txt", "r")
    y_read_find_OS = y.read()
    y.close()
    x_time = str(datetime.datetime.now().time())
    print("[" + x_time + "]" + " " + "[Status:Preparing] ATOWU Running on : " + y_read_find_OS.strip())
    if os.path.exists("find_os.bat"):
        os.remove("find_os.bat")
    if os.path.exists("result_findOS.txt"):
        os.remove("result_findOS.txt")
    
def success_start_messages():
    x_time = str(datetime.datetime.now().time())
    print("[" + x_time + "]" + " " + "[Status:Running] SUCCESS!! ATOWU is Running, time start : " + x_time)
    
def enginev2():
    while 3 > 2 :
        # global pid_windows_defend_update
        # global status_bits
        # global status_dosvc
        # global status_wuauserv
        global x_bits
        global x_wuauserv
        global x_dosvc
        global x_pid_windows_defend_update
        if less_mode == "1":
            print("engine_less_mode()")
        # status_wuauserv = "NOT_FOUND"
        # status_bits = "NOT_FOUND"
        # status_dosvc = "NOT_FOUND"
        x = open("find_bits.bat", "w")
        x.write("@echo off\nfor /f  " + '"tokens=4"' + " %%b in ('sc query bits ^| findstr STATE') do echo %%b > bits.txt")
        x.close()
        system('"find_bits.bat"')
        x = open("bits.txt", "r")
        x_bits = x.read()
        x.close()
        x = open("find_wuauserv.bat", "w")
        x.write("@echo off\nfor /f " + '"tokens=4"' + " %%b in ('sc query wuauserv ^| findstr STATE') do echo %%b > wuauserv.txt")
        x.close()
        system('"find_wuauserv.bat"')
        x = open("wuauserv.txt", "r")
        x_wuauserv = x.read()
        x.close()
        x = open("find_dosvc.bat", "w")
        x.write("@echo off\nfor /f " + '"tokens=4"' + " %%b in ('sc query DoSvc ^| findstr STATE') do echo %%b > dosvc.txt")
        x.close()
        system('"find_dosvc.bat"')
        x = open("dosvc.txt", "r")
        x_dosvc = x.read()
        x.close()
        x = open("pid_windefend.bat", "w")
        x.write("@echo off\nfor /f " + '"tokens=2"' + " %%b in ('tasklist ^| findstr MpCmdRun.exe') do echo %%b > pid_windefend.txt")
        x.close()
        system('"pid_windefend.bat"')
        if os.path.exists("pid_windefend.txt"):
            x = open("pid_windefend.txt", "r")
            x_pid_windows_defend_update = x.read()
            x.close()
            os.remove("pid_windefend.txt")
        else:
            x_pid_windows_defend_update = "NOT_FOUND"
        if os.path.exists("find_bits.bat"):
            os.remove("find_bits.bat")
        if os.path.exists("bits.txt"):
            os.remove("bits.txt")
        if os.path.exists("find_wuauserv.bat"):
            os.remove("find_wuauserv.bat")
        if os.path.exists("wuauserv.txt"):
            os.remove("wuauserv.txt")
        if os.path.exists("find_dosvc.bat"):
            os.remove("dosvc.txt")
        if os.path.exists("pid_windefend.bat"):
            os.remove("pid_windefend.bat")
        if os.path.exists("pid_windefend.txt"):
            os.remove("pid_windefend.txt")
        if x_bits.strip() == "RUNNING":
            bits()
        if x_wuauserv.strip() == "RUNNING":
            wuauserv.check_service(self)

def bits():
    if x_bits.strip() == "RUNNING":
        x_time = str(datetime.datetime.now().time())
        print("[" + x_time + "]" + " " + "[Status:FOUND!!!] [Service] Background Windows Update is Running, trying to shutting down...")
        system('sc config bits start= disabled>NUL')
        x = open("off_bits.bat", "w")
        x.write("@echo off\nfor /f " + '"tokens=7"' + " %%b in ('net stop bits ^| findstr service') do echo %%b > result_off_bits.txt")
        x.close()
        system('"off_bits.bat"')
        if os.path.exists("off_bits.bat"):
            os.remove("off_bits.bat")
        x = open("result_off_bits.txt", "r")
        x_bits_result = x.read()
        x.close()
        x = open("error_bits.bat", "w")
        x.write("@ECHO OFF\nfor /f " + '"tokens=3"' + " %%b in ('sc query bits ^| findstr SERVICE_EXIT_CODE') do echo %%b > error_bits.txt")
        x.close()
        system('"error_bits.bat"')
        if os.path.exists("error_bits.bat"):
            os.remove("error_bits.bat")
        x = open("error_bits.txt", "r")
        x_error_read_bits = x.read()
        x.close()
        if x_error_read_bits.strip() == "0":
            if os.path.exists("error_bits.txt"):
                os.remove("error_bits.txt")
            if os.path.exists("result_off_bits.txt"):
                os.remove("result_off_bits.txt")
            if x_bits_result == "Please":
                x_time = str(datetime.datetime.now().time())
                print("[" + x_time + "]" + " " + "[Status:QUEUED] [Service] Background Windows Update is Starting or Stopping... ")
                while 3 > 2:
                    x = open("off_bits.bat", "w")
                    x.write("@echo off\nfor /f " + '"tokens=7"' + " %%b in ('net stop bits ^| findstr service') do echo %%b > result_off_bits.txt")
                    x.close()
                    system('"off_bits.bat"')
                    if os.path.exists("off_bits.bat"):
                        os.remove("off_bits.bat")
                    x = open("result_off_bits.txt", "r")
                    x_bits_result = x.read()
                    x.close()
                    if x_bits_result == "Please":
                        x = "Running"
                    else:
                        bits_check()
            else:
                bits_check()
        else:
            x_time = str(datetime.datetime.now().time())
            print("[" + x_time + "]" + " " + "[Status:ERROR] [Service] Somethings Wrong, hang on while we rolling back the current action....")
            x = open("rolling_bits_on.bat", "w")
            x.write("@ECHO OFF\nsc config bits start= auto>NUL\nfor /f " + '"tokens=*"' + " %%b in ('net start bits') do set VAR=on\nexit")
            x.close()
            system('"rolling_bits_on.bat"')
            sleep(3.0)
            if os.path.exists("rolling_bits_on.bat"):
                os.remove("rolling_bits_on.bat")
            x = open("rolling_bits_off.bat", "w")
            x.write("@ECHO OFF\nsc config bits start= disabled>NUL\nfor /f " + '"tokens=*"' + " %%b in ('net stop bits') do set VAR=off\nexit")
            x.close()
            system('"rolling_bits_off.bat"')
            if os.path.exists("rolling_bits_off.bat"):
                os.remove("rolling_bits_off.bat")
            bits_check()
            
    else:
        x_time = str(datetime.datetime.now().time())
        print("[" + x_time + "]" + " " + "Background Windows Update is Disabled")
        enginev2()

def bits_check():
    x = open("off_bits.bat", "w")
    x.write("@echo off\nfor /f " + '"tokens=4"' + " %%b in ('sc query bits ^| findstr STATE') do echo %%b > result_off_bits.txt")
    x.close()
    system('"off_bits.bat"')
    if os.path.exists("off_bits.bat"):
        os.remove("off_bits.bat")
    if os.path.exists("result_off_bits.txt"):
        x = open("result_off_bits.txt", "r")
        x_bits_result = x.read()
        x.close()
        if x_bits_result == "RUNNING":
            bits_error_attempt_1()
        else:
            bits_print_message_and_quit()
    else:
        x_time = str(datetime.datetime.now().time())
        print("[" + x_time + "]" + " " + "[Status:ERROR] [Service] Somethings Wrong, hang on while we rolling back the current action....")
        bits_check()
        

def bits_error_attempt_1():
    x_time = str(datetime.datetime.now().time())
    print("[" + x_time + "]" + " " + "[Status:Failed_Shutting_down] [Service] Background Windows Update Failed to Shut Down, trying again... (Attempt:1)")
    system('sc config bits start= disabled>NUL')
    x = open("off_bits.bat", "w")
    x.write("@echo off\nfor /f " + '"tokens=7"' + " %%b in ('net stop bits ^| findstr service') do echo %%b > result_off_bits.txt")
    x.close()
    system('"off_bits.bat"')
    if os.path.exists("off_bits.bat"):
        os.remove("off_bits.bat")
    x = open("result_off_bits.txt", "r")
    x_bits_result = x.read()
    x.close()
    if os.path.exists("result_off_bits.txt"):
        os.remove("result_off_bits.txt")
    if x_bits_result == "RUNNING":
        x_time = str(datetime.datetime.now().time())
        print("[" + x_time + "]" + " " + "[Status:Failed_Shutting_down] [Service] Background Windows Update Failed to Shut Down, trying again... (Attempt:2)")
        system('sc config bits start= disabled>NUL')
        x = open("off_bits.bat", "w")
        x.write("@echo off\nfor /f " + '"tokens=7"' + " %%b in ('net stop bits ^| findstr service') do echo %%b > result_off_bits.txt")
        x.close()
        system('"off_bits.bat"')
        if os.path.exists("off_bits.bat"):
            os.remove("off_bits.bat")
        x = open("result_off_bits.txt", "r")
        x_bits_result = x.read()
        x.close()
        if os.path.exists("result_off_bits.txt"):
            os.remove("result_off_bits.txt")
        if x_bits_result == "RUNNING":
            x_time = str(datetime.datetime.now().time())
            print("[" + x_time + "]" + " " + "[Status:Failed_Shutting_down] [Service] Background Windows Update Failed to Shut Down, trying again... (Attempt:3)")
            system('sc config bits start= disabled>NUL')
            x = open("off_bits.bat", "w")
            x.write("@echo off\nfor /f " + '"tokens=7"' + " %%b in ('net stop bits ^| findstr service') do echo %%b > result_off_bits.txt")
            x.close()
            system('"off_bits.bat"')
            if os.path.exists("off_bits.bat"):
                os.remove("off_bits.bat")
            x = open("result_off_bits.txt", "r")
            x_bits_result = x.read()
            x.close()
            if os.path.exists("result_off_bits.txt"):
                os.remove("result_off_bits.txt")
            if x_bits_result == "RUNNING":
                x_time = str(datetime.datetime.now().time())
                print("[" + x_time + "]" + " " + "[Status:Failed_Shutting_down] [Service] Too Many Attempts to Shutting down Background Windows Update, Skip to next Task...")
                print("wuauserv()")
            else:
                bits_print_message_and_quit()
        else:
            bits_print_message_and_quit()
    else:
        bits_print_message_and_quit()

def bits_print_message_and_quit():
    x_time = str(datetime.datetime.now().time())
    print("[" + x_time + "]" + " " + "[Status:Success_Shutting_down] [Service] Background Windows Update Successfully Shut down ")
    enginev2()

class wuauserv():
    def check_service(self):
        if x_wuauserv.strip() == "RUNNING":
            wuauserv.process_service(self)
        else:
            x_time = str(datetime.datetime.now().time())
            print("[" + x_time + "]" + " " + "Windows Update is Disabled")
            enginev2()

    
    def process_service(self):
            x_time = str(datetime.datetime.now().time())
            print("[" + x_time + "]" + " " + "[Status:FOUND!!!] [Service] Windows Update is Running, trying to shutting down....")
            system('sc config wuauserv start= disabled>NUL')
            x = open("off_wuauserv.bat", "w")
            x.write("@echo off\nfor /f " + '"tokens=7"' + " %%b in ('net stop wuauserv ^| findstr service') do echo %%b > result_off_wuauserv.txt\nexit")
            x.close()
            system('"off_wuauserv.bat"')
            if os.path.exists("off_wuauserv.bat"):
                os.remove("off_wuauserv.bat")
            x = open("result_off_wuauserv.txt", "r")
            x_wuauserv_result = x.read()
            x.close()
            x = open("error_wuauserv.bat", "w")
            x.write("@echo off\nfor /f \"tokens=3\" %%b in (\'sc query bits ^| findstr SERVICE_EXIT_CODE\') do echo %%b > error_wuauserv.txt")
            x.close()
            system('"error_wuauserv.bat"')   
            if os.path.exists("error_wuauserv.bat"):
                os.remove("error_wuauserv.bat")
            x = open("error_wuauserv.txt", "r")
            x_error_read_wuauserv = x.read()
            x.close()
            if x_error_read_wuauserv.strip() == "0":
                if os.path.exists("error_wuauserv.txt"):
                    os.remove("error_wuauser.txt")
                if os.path.exists("result_off_wuauserv.txt"):
                    os.remove("result_off_wuauserv.txt")
                if x_wuauserv_result == "Please":
                    x_time = str(datetime.datetime.now().time())
                    print("[" + x_time + "]" + " " + "[Status:QUEUED] [Service] Windows Update is Starting or Stopping... ")
                    while 3 > 2:
                        x = open("off_wuauserv.bat", "w")
                        x.write("@echo off\nfor /f \"tokens=7\" %%b in ('net stop wuauserv ^| findstr service') do echo %%b > result_off_wuauserv.txt")
                        x.close()
                        system('"off_wuauserv.bat"')
                        if os.path.exists("off_wuauserv.bat"):
                            os.remove("off_wuauserv.bat")
                        x = open("result_off_wuauserv.txt", "r")
                        x_wuauserv_result = x.read()
                        x.close()
                        if x_wuauserv_result == "Please":
                            x = "Running"
                        else:
                            wuauserv.check_state(self)
                else:
                    wuauserv.check_state(self)
            else:
                x_time = str(datetime.datetime.now().time())
                print("[" + x_time + "]" + " " + "[Status:ERROR] [Service] Somethings Wrong, hang on while we rolling back the current action....")

    def check_state(self):
        x = open("check_wuauserv.bat", "w")
        x.write("@echo off\n for /f \"tokens=4\" %%b in ('sc query wuauserv ^| findstr STATE') do echo %%b > result_check_wuauserv.txt\nexit")
        x.close()
        system('"check_wuauserv.bat"')
        if os.path.exists("check_wuauserv.bat"):
            os.remove('check_wuauserv.bat')
        if os.path.exists('result_check_wuauserv.txt'):
            x = open('result_check_wuauserv.txt', 'r')
            x_check_result = x.read()
            x.close()
            if x_check_result == "RUNNING":
                wuauserv.error(self)
            else:
                wuauserv.print_message_and_quit(self)
        else:
            x_time = str(datetime.datetime.now().time())
            print("[" + x_time + "]" + " " + "[Status:ERROR] [Service] Somethings Wrong, hang on while we rolling back the current action....")
            wuauserv.check_state(self)

    def error(self):
        x_time = str(datetime.datetime.now().time())
        print("[" + x_time + "]" + " " + "[Status:Failed_Shutting_down] [Service] Windows Update Failed to Shut Down, trying again.... (Attempt:1)")

    def print_message_and_quit(self):
        x_time = str(datetime.datetime.now().time())
        print("[" + x_time + "]" + " " + "[Status:Success_Shutting_down] [Service] Windows Update Successfully Shut down ")
        enginev2()


def init_main():
    global self
    self = ""
    date()
    menu_message()
    check_less_mode()
    check_debug_mode()
    check_admin()
    find_OS()
    success_start_messages()
    enginev2()

init_main()



