@echo off
:: ������ǰĿ¼����Ŀ¼�µ�*.md�ļ�����ǰĿ¼
:: for /r . %%a in (*.md) do if exist "%%a" copy /y "%%a" .
for /r . %%a in (*.md) do if exist "%%a" move /y "%%a".

pause