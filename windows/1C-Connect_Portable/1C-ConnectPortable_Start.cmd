@echo off
REM 1C-Connect Portable Run Copyright (©) 2024 userunsudo

mkdir App
mkdir SystemFolders\AppData\Local
mkdir SystemFolders\AppData\Roaming
mkdir SystemFolders\Desktop
mkdir SystemFolders\Downloads\1C-Connect

set OneS=%~dp0
set UserProfile=%OneS%SystemFolders
:set HomePath=%OneS%SystemFolders
:set UserName=%OneS%SystemFolders
:set AllUsersProfile=%OneS%SystemFolders\ProgramData
:set ProgramData=%OneS%SystemFolders\ProgramData
:set AppData=%OneS%SystemFolders\AppData\Roaming
:set LocalAppData=%OneS%SystemFolders\AppData\Local
:set TEMP=%OneS%SystemFolders\AppData\Local\Temp
:set TMP=%OneS%SystemFolders\AppData\Local\Temp

start "" "%OneS%App\app\bin\connect.exe"
:pause
