@echo off
echo.
echo      MySQL���ݿⱸ��

echo *****************************
echo.
echo ������ %date%
echo ʱ���� %time%
echo.
echo *****************************

:: ����Ymd����Ϊ���ڸ�ʽ��yyyyMMdd
set "Ymd=%date:~,4%%date:~5,2%%date:~8,2%"

:: �����ļ���
md "D:\JDBC\%Ymd%"

:: �������������ݿ��ÿո����
"mysqldump" -h 172.20.95.126 --single-transaction --databases mindoc_db -uroot -p1234 --default-character-set=utf8mb4 > "D:\JDBC\%Ymd%\backup.sql"

echo.

echo MySQL���ݿⱸ����ɣ�����м�顣����

echo.
echo.

:: ��ʾ�밴���������
pause