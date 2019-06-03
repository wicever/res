@echo off
:: 拷贝当前目录的子目录下的*.md文件到当前目录
:: for /r . %%a in (*.md) do if exist "%%a" copy /y "%%a" .
for /r . %%a in (*.md) do if exist "%%a" move /y "%%a".

pause