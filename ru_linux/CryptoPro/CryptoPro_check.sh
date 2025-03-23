#!/bin/bash

# CryptoPro_check.sh
# Author: @usrunsudo

SCRIPT_PATH=$1
CryptoPro_FOLDER="/opt/cprocsp"
CryptoPro_license="/etc/opt/cprocsp/license.ini"

echo ""
echo -e "\033[41mCryptoPro check\033[0m"

echo ""
echo -e "\033[41m$CryptoPro_FOLDER\033[0m"
if [ -d $CryptoPro_FOLDER ]
then
	echo "Директория существует, CryptoPro установлен или удален не полностью"
else
	echo "Директория отсутствует, CryptoPro не установлен"
fi
if [ -d /var/opt/cprocsp ]
then
	echo -e "\033[41m/var/opt/cprocsp\033[0m"
	echo "Присутствуют следы CryptoPro"
fi
if [ -d /etc/opt/cprocsp ]
then
	echo -e "\033[41m/etc/opt/cprocsp\033[0m"
	echo "Присутствуют следы CryptoPro"
fi

echo ""
echo "CryptoPro version"
echo -e "\033[41m/opt/cprocsp/bin/amd64/csptestf -enum -info\033[0m"
if [ -f /opt/cprocsp/bin/amd64/csptestf ]
then
	/opt/cprocsp/bin/amd64/csptestf -enum -info
else
	echo "Файл csptestf не существует!"
fi

echo ""
echo "CryptoPro license ($CryptoPro_license)"
echo -e "\033[41m/opt/cprocsp/sbin/amd64/cpconfig -license -view\033[0m"
if [ -f /opt/cprocsp/sbin/amd64/cpconfig ]
then
	/opt/cprocsp/sbin/amd64/cpconfig -license -view
else
	echo "Файл cpconfig не существует!"
fi

echo ""
echo "Проверка установленных пакетов cprocsp (dpkg -l)"
echo -e "\033[41mdpkg -l | grep cprocsp\033[0m"
dpkg -l | grep cprocsp

# echo ""
# echo "Проверка установленных пакетов cprocsp (dpkg-query)"
# echo -e "\033[41mdpkg-query -f '\${binary:Package}\.n' -W | grep cprocsp\033[0m"
# dpkg-query -f '${binary:Package}\n' -W | grep cprocsp

echo ""
echo "Проверка установленных пакетов cprocsp (dpkg-query)"
echo -e "\033[41mdpkg-query -W | grep cprocsp\033[0m"
dpkg-query -W | grep cprocsp

echo ""
echo "Проверка установленных пакетов cprocsp (apt list)"
echo -e "\033[41mapt list --installed | grep cprocsp\033[0m"
apt list --installed | grep cprocsp

echo ""
