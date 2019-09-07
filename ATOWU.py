from os import system
from time import sleep

def Background_Windows_Update():
    print("Turning off Background Windows Update")
    system('echo off')
    system('sc config bits start= disabled')
    system('net stop bits')
    Windows_Update()

def Windows_Update():
    print("Turning off Windows Update")
    system('echo off')
    system('sc config wuauserv start= disabled')
    system('net stop wuauserv')
    Delivery_Optimization()

def Delivery_Optimization():
    print("Turning Off Delivery Optimization")
    system('echo off')
    system('sc config DoSvc start= disabled')
    system('net stop DoSvc')
    sleep(2)

Background_Windows_Update()


