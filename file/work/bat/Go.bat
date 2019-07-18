@echo off
title GRC.Office StartMENU By Songjw
color 0a

:: 设置工程目录
set GRC_PATH=D:\Develop\Workspaces\CMCC_OAV5

:MENU
CLS
ECHO.
ECHO. =-=-=-=-=菜单=-=-=-=-=
ECHO.
ECHO. 1 执行命令run
ECHO.
ECHO. 2 执行命令debug
ECHO.
ECHO. 3 执行命令clean
ECHO.
ECHO. 4 执行命令clean-build-debug
ECHO.
ECHO. 5 执行命令build-debug
ECHO.
ECHO. 6 执行命令stop
ECHO.
ECHO. 7 执行命令build eclipse-project
ECHO.
ECHO. 8 退 出
ECHO.
ECHO.
ECHO.

set /p user_input=请输入数字：

if %user_input% equ 1 goto :run

if %user_input% equ 2 goto :debug

if %user_input% equ 3 goto :clean

if %user_input% equ 4 goto :clean-build-debug

if %user_input% equ 5 goto :build

if %user_input% equ 6 goto :stop

if %user_input% equ 7 goto :build-ep

if "%%a"=="8" exit

PAUSE
set "user_input="
goto :MENU
 
:run
rem explorer "run 启动本地工程"
ECHO.
ECHO.
echo %time% run ...... 
cd %GRC_PATH%
call hd run
ECHO.
ECHO.
set /p=请按[回车]返回菜单
goto :MENU
 
:debug
rem echo 执行命令hd debug
ECHO.
ECHO.
echo %time% run with debug ......
cd %GRC_PATH%
call hd debug
ECHO.
ECHO.
set /p=请按[回车]返回菜单
GOTO :MENU

:clean
rem echo 执行命令build clean、build
ECHO.
ECHO.
echo %time% cleanning ......
cd %GRC_PATH%
call build clean
ECHO.
ECHO.
set /p=请按[回车]返回菜单
GOTO :MENU

:clean-build-debug
rem echo 执行命令build clean、build
ECHO.
ECHO.
echo %time% cleanning ......
cd %GRC_PATH%
call build clean
ECHO.
ECHO.
echo %time% building ......
call build
ECHO.
ECHO.
echo %time% run with debug ......
call hd debug
ECHO.
ECHO.
set /p=请按[回车]返回菜单
GOTO :MENU

:build
rem echo 执行命令build
ECHO.
ECHO.
echo %time% building ......
cd %GRC_PATH%
call build
ECHO.
ECHO.
echo %time% run with debug ......
call hd debug
ECHO.
ECHO.
set /p=请按[回车]返回菜单
GOTO :MENU

:stop
rem echo 执行命令build
ECHO.
ECHO.
echo %time% stopping ......
cd %GRC_PATH%
call hd stop
ECHO.
ECHO.
set /p=请按[回车]返回菜单
GOTO :MENU

:build-ep
rem echo 执行命令build
ECHO.
ECHO.
echo %time% build eclipse-project ......
cd %GRC_PATH%
call build eclipse-project
ECHO.
ECHO.
set /p=请按[回车]返回菜单
GOTO :MENU

