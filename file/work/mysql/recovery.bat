@echo off

::pause
echo.
set /p sqldate=请输入备份日期：
source  mindoc_db_%sqldate%.sql