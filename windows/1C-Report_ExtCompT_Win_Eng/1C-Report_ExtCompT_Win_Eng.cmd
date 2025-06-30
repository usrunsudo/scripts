@echo off
::1C-Report_ExtCompT_Win_Eng
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage /v 1250 /t REG_SZ /d c_1251.nls /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage /v 1251 /t REG_SZ /d c_1251.nls /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage /v 1252 /t REG_SZ /d c_1251.nls /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage /v ACP /t REG_SZ /d 1251 /f
