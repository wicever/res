@echo off
rem 处理MinDoc中导出的md文件
rem 将当前目录下的"工作.zip"、"生活.zip"解压
rem 将解压的文件夹中的md文件移到根目录
rem 再压缩

set "CURRENT_DIR=%cd%"
echo %CURRENT_DIR%

IF EXIST "%CURRENT_DIR%\工作.zip" (
  start /wait winrar x "%CURRENT_DIR%\工作.zip" "%CURRENT_DIR%\工作\"  
  ::del "工作.zip"
  cd %CURRENT_DIR%\工作\      
  ::for /r . %%a in (*.md not README.md) do if exist "%%a" move /y "%%a".
  ::将markdown下所有除了README.md外md文件移到当前目录
  for /f "delims=" %%a in ('dir /a-d/b/s *.md') do (
    echo "%%~nxa" | find "README.md" >nul || move "%%a"
  )
  move "%CURRENT_DIR%\工作\markdown\README.md"
  cd ..
  start /wait winrar a "工作_new.zip" "工作\"
  rd /s/q "%CURRENT_DIR%\工作"
)

IF EXIST "%CURRENT_DIR%\生活.zip" (
  start /wait winrar x "%CURRENT_DIR%\生活.zip" "%CURRENT_DIR%\生活\"  
  ::del "生活.zip"
  cd %CURRENT_DIR%\生活\      
  ::for /r . %%a in (*.md not README.md) do if exist "%%a" move /y "%%a".
  ::将markdown下所有除了README.md外md文件移到当前目录
  for /f "delims=" %%a in ('dir /a-d/b/s *.md') do (
    echo "%%~nxa" | find "README.md" >nul || move "%%a"
  )
  move "%CURRENT_DIR%\生活\markdown\README.md"
  cd ..
  start /wait winrar a "生活_new.zip" "生活\"
  rd /s/q "%CURRENT_DIR%\生活"
)

rem goto :EOF 
pause
del "工作.zip"
del "生活.zip"
del "工作_new.zip"
del "生活_new.zip"
