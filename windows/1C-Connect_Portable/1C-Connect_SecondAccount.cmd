@echo off
REM 1C-Connect Portable Run Copyright (©) 2024 userunsudo


mkdir 1C-Connect_2\AppData\Local
mkdir 1C-Connect_2\AppData\Roaming
mkdir 1C-Connect_2\Desktop
mkdir 1C-Connect_2\Downloads\1C-Connect

set OneS=%~dp0
set UserProfile=%OneS%1C-Connect_2
:set HomePath=%OneS%1C-Connect_2
:set UserName=%OneS%1C-Connect_2
:set AllUsersProfile=%OneS%1C-Connect_2\ProgramData
:set ProgramData=%OneS%1C-Connect_2\ProgramData
:set AppData=%OneS%1C-Connect_2\AppData\Roaming
:set LocalAppData=%OneS%1C-Connect_2\AppData\Local
:set TEMP=%OneS%1C-Connect_2\AppData\Local\Temp
:set TMP=%OneS%1C-Connect_2\AppData\Local\Temp

start "" "%LocalAppData%\Programs\Connect Desktop\app\bin\connect.exe"
:pause
