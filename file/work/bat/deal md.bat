@echo off
rem ����MinDoc�е�����md�ļ�
rem ����ǰĿ¼�µ�"����.zip"��"����.zip"��ѹ
rem ����ѹ���ļ����е�md�ļ��Ƶ���Ŀ¼
rem ��ѹ��

set "CURRENT_DIR=%cd%"
echo %CURRENT_DIR%

IF EXIST "%CURRENT_DIR%\����.zip" (
  start /wait winrar x "%CURRENT_DIR%\����.zip" "%CURRENT_DIR%\����\"  
  del "����.zip"
  cd %CURRENT_DIR%\����\      
  ::for /r . %%a in (*.md not README.md) do if exist "%%a" move /y "%%a".
  ::��markdown�����г���README.md��md�ļ��Ƶ���ǰĿ¼
  for /f "delims=" %%a in ('dir /a-d/b/s *.md') do (
    echo "%%~nxa" | find "README.md" >nul || move "%%a"
  )
  move "%CURRENT_DIR%\����\markdown\README.md"
  cd ..
  start /wait winrar a "����.zip" "����\"
  rd /s/q "%CURRENT_DIR%\����"
)

IF EXIST "%CURRENT_DIR%\����.zip" (
  start /wait winrar x "%CURRENT_DIR%\����.zip" "%CURRENT_DIR%\����\"  
  del "����.zip"
  cd %CURRENT_DIR%\����\      
  ::for /r . %%a in (*.md not README.md) do if exist "%%a" move /y "%%a".
  ::��markdown�����г���README.md��md�ļ��Ƶ���ǰĿ¼
  for /f "delims=" %%a in ('dir /a-d/b/s *.md') do (
    echo "%%~nxa" | find "README.md" >nul || move "%%a"
  )
  move "%CURRENT_DIR%\����\markdown\README.md"
  cd ..
  start /wait winrar a "����.zip" "����\"
  rd /s/q "%CURRENT_DIR%\����"
)

rem goto :EOF 
rem pause