@echo off
title GRC.Office StartMENU By Songjw
color 0a

:: ���ù���Ŀ¼
set GRC_PATH=D:\Develop\Workspaces\CMCC_OAV5

:MENU
CLS
ECHO.
ECHO. =-=-=-=-=�˵�=-=-=-=-=
ECHO.
ECHO. 1 ִ������run
ECHO.
ECHO. 2 ִ������debug
ECHO.
ECHO. 3 ִ������clean
ECHO.
ECHO. 4 ִ������clean-build-debug
ECHO.
ECHO. 5 ִ������build-debug
ECHO.
ECHO. 6 ִ������stop
ECHO.
ECHO. 7 ִ������build eclipse-project
ECHO.
ECHO. 8 �� ��
ECHO.
ECHO.
ECHO.

set /p user_input=���������֣�

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
rem explorer "run �������ع���"
ECHO.
ECHO.
echo %time% run ...... 
cd %GRC_PATH%
call hd run
ECHO.
ECHO.
set /p=�밴[�س�]���ز˵�
goto :MENU
 
:debug
rem echo ִ������hd debug
ECHO.
ECHO.
echo %time% run with debug ......
cd %GRC_PATH%
call hd debug
ECHO.
ECHO.
set /p=�밴[�س�]���ز˵�
GOTO :MENU

:clean
rem echo ִ������build clean��build
ECHO.
ECHO.
echo %time% cleanning ......
cd %GRC_PATH%
call build clean
ECHO.
ECHO.
set /p=�밴[�س�]���ز˵�
GOTO :MENU

:clean-build-debug
rem echo ִ������build clean��build
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
set /p=�밴[�س�]���ز˵�
GOTO :MENU

:build
rem echo ִ������build
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
set /p=�밴[�س�]���ز˵�
GOTO :MENU

:stop
rem echo ִ������build
ECHO.
ECHO.
echo %time% stopping ......
cd %GRC_PATH%
call hd stop
ECHO.
ECHO.
set /p=�밴[�س�]���ز˵�
GOTO :MENU

:build-ep
rem echo ִ������build
ECHO.
ECHO.
echo %time% build eclipse-project ......
cd %GRC_PATH%
call build eclipse-project
ECHO.
ECHO.
set /p=�밴[�س�]���ز˵�
GOTO :MENU

