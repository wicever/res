@echo off
rem version:v1.0

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
set mysqlHost=127.20.95.126
::echo 准备备份服务器%mysqlHost%的数据库。

::pause
echo.
echo 
mysqldump -h %mysqlHost% -uroot -p1234 --databases mindoc_db > mindoc_db(%mysqlHost%)_%timename%.sql