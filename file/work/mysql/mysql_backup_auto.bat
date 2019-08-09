@echo off
rem version:v1.0

::set "CURRENT_DIR=%cd%"
set "CURRENT_DIR=D:\Develop\mindoc_windows_amd64\mindoc_db_backup"
echo %CURRENT_DIR%

set "year=%date:~0,4%"
set "month=%date:~5,2%"
set "day=%date:~8,2%"
set "hour_ten=%time:~0,1%"
set "hour_one=%time:~1,1%"
set "minute=%time:~3,2%"
set "second=%time:~6,2%"

if "%hour_ten%" == " " (
   :: type nul > %year%%month%%day%0%hour_one%%minute%%second%.txt
   set "timename=%year%%month%%day%0%hour_one%"
) else (
   :: type nul > %year%%month%%day%%hour_ten%%hour_one%%minute%%second%.txt
   set "timename=%year%%month%%day%%hour_ten%%hour_one%"
)
::set /p mysqlHost=请输入服务器地址：

::if not defined mysqlHost set mysqlHost=127.0.0.1
set mysqlHost=172.20.95.126
::echo 准备备份服务器%mysqlHost%的数据库。
@echo off>nul 2>./DB_Backup/%mysqlHost%_%timename%_err.txt 3>./DB_Backup/%mysqlHost%_%timename%_log.txt 4>./DB_Backup/%mysqlHost%_%timename%_log.txt
::pause
echo.
echo 
mysqldump -h %mysqlHost% -uroot -pJiWen@MySql --databases mindoc_db > ./DB_Backup/mindoc_db(%mysqlHost%)_%timename%.sql

::删除备份8天以上的文件
forfiles /P  %CURRENT_DIR%\DB_Backup /S /C "cmd /c del @path" /D -8