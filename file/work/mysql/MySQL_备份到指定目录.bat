@echo off
echo.
echo      MySQL数据库备份

echo *****************************
echo.
echo 今天是 %date%
echo 时间是 %time%
echo.
echo *****************************

:: 设置Ymd变量为日期格式：yyyyMMdd
set "Ymd=%date:~,4%%date:~5,2%%date:~8,2%"

:: 创建文件夹
md "D:\JDBC\%Ymd%"

:: 备份命令，多个数据库用空格隔开
"mysqldump" -h 172.20.95.126 --single-transaction --databases mindoc_db -uroot -p1234 --default-character-set=utf8mb4 > "D:\JDBC\%Ymd%\backup.sql"

echo.

echo MySQL数据库备份完成，请进行检查。。。

echo.
echo.

:: 提示请按任意键继续
pause