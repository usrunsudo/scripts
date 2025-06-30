@echo off
REM 1C Enterprise Shell Portable Run Copyright (©) 2021 Nikita Technik

set OneS=%~dp0
set UserProfile=%OneS%SystemFolders
set AllUsersProfile=%OneS%SystemFolders\ProgramData
set ProgramData=%OneS%SystemFolders\ProgramData
set AppData=%OneS%SystemFolders\AppData\Roaming
set LocalAppData=%OneS%SystemFolders\AppData\Local

echo 1C Enterprise Shell Portable Run
echo.
echo.
echo.
echo Environment Variable
echo.
echo OneS = %OneS%
echo UserProfile= %UserProfile%
echo AllUsersProfile= %AllUsersProfile%
echo ProgramData = %ProgramData%
echo AppData = %AppData%
echo LocalAppData = %LocalAppData%
echo.
echo.
echo.
echo Run 1C x32 1cestart.exe

echo.
PAUSE
echo.

echo %OneS%1cv8_x32\common\1cestart.exe
"%OneS%1cv8_x32\common\1cestart.exe"
