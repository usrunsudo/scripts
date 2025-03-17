#!/bin/bash

# ru_gos_certs_install_v1.sh
# Author: @usrunsudo

# При установке в хранилище m* = machine - все установленное доступно Всем пользователям системы.
# При установке в хранилище u* = user - все установленное доступно только пользователю, от которого производилась установка.

clear

if [ "$1" == "" ]
	then
		SCRIPT_FOLDER=$HOME
	else
		SCRIPT_FOLDER=$1
fi

echo "SCRIPT_FOLDER = $SCRIPT_FOLDER"
echo ""

echo "Update CER and CRL"
echo -n "Download new CER/CRT and CRL? (y/yes or n/no): "
	read ANSWER
	if [ "$ANSWER" == "y" ] || [ "$ANSWER" == "yes" ] || [ "$ANSWER" == "Y" ];
	then
		if [ -d "$SCRIPT_FOLDER/Certs" ]
			then
				echo "Директория существует: $SCRIPT_FOLDER/Certs"
				cd $SCRIPT_FOLDER/
				# tar -cvf Certs_backup.tar ./Certs/
			else
				mkdir "$SCRIPT_FOLDER/Certs"
		fi
		if [ -d "$SCRIPT_FOLDER/Certs/RootCA_RU" ]
			then
				echo "Директория существует: $SCRIPT_FOLDER/Certs/RootCA_RU"
			else
				mkdir "$SCRIPT_FOLDER/Certs/RootCA_RU"
		fi
		if [ -d "$SCRIPT_FOLDER/Certs/roskazna" ]
			then
				echo "Директория существует: $SCRIPT_FOLDER/Certs/roskazna"
			else
				mkdir "$SCRIPT_FOLDER/Certs/roskazna"
		fi
		if [ -d "$SCRIPT_FOLDER/Certs/CRL" ]
			then
				echo "Директория существует: $SCRIPT_FOLDER/Certs/CRL"
			else
				mkdir "$SCRIPT_FOLDER/Certs/CRL"
		fi
		
		echo ""
		
		# Портал УФО по ЭЦП
		# https://e-trust.gosuslugi.ru/#/portal/mainca

		# Сертификаты и Списки аннулированных сертификатов Удостоверяющего центра Федерального казначейства
		# http://crl.roskazna.ru/crl/

		# ПАК "Минкомсвязь России" Класс средств ЭП: КВ2 Средства УЦ: ПАК «Головной УЦ»
		wget -O "$SCRIPT_FOLDER/Certs/RootCA_RU/4BC6DC14D97010C41A26E058AD851F81C842415A.cer" https://e-trust.gosuslugi.ru/app/scc/portal/api/v1/portal/ca/download/4BC6DC14D97010C41A26E058AD851F81C842415A
		wget -O "$SCRIPT_FOLDER/Certs/RootCA_RU/AFF05C9E2464941E7EC2AB15C91539360B79AA9D.cer" https://e-trust.gosuslugi.ru/app/scc/portal/api/v1/portal/ca/download/AFF05C9E2464941E7EC2AB15C91539360B79AA9D

		# ПАК "Минкомсвязь России" Класс средств ЭП: КС3 Средства УЦ: КриптоПро УЦ 2.0
		wget -O "$SCRIPT_FOLDER/Certs/RootCA_RU/9BA648660733ED7A550BCEA03A20E14B8F25C99B.cer" https://e-trust.gosuslugi.ru/app/scc/portal/api/v1/portal/ca/download/9BA648660733ED7A550BCEA03A20E14B8F25C99B

		# ПАК "Минцифры России" Класс средств ЭП: КВ2 Средства УЦ: ПАК «Головной УЦ»
		wget -O "$SCRIPT_FOLDER/Certs/RootCA_RU/2F0CB09BE3550EF17EC4F29C90ABD18BFCAAD63A.cer" https://e-trust.gosuslugi.ru/app/scc/portal/api/v1/portal/ca/download/2F0CB09BE3550EF17EC4F29C90ABD18BFCAAD63A
		wget -O "$SCRIPT_FOLDER/Certs/RootCA_RU/1D13121735DD6E1F59EA58C786B8F7E8B7E6E20F.cer" https://e-trust.gosuslugi.ru/app/scc/portal/api/v1/portal/ca/download/1D13121735DD6E1F59EA58C786B8F7E8B7E6E20F

		# ПАК "Головной удостоверяющий центр"
		wget -O "$SCRIPT_FOLDER/Certs/RootCA_RU/8CAE88BBFD404A7A53630864F9033606E1DC45E2.cer" https://e-trust.gosuslugi.ru/app/scc/portal/api/v1/portal/ca/download/8CAE88BBFD404A7A53630864F9033606E1DC45E2

		# Федеральное казначейство
		# https://e-trust.gosuslugi.ru/#/portal/registry/ufo-certificate-card/23754 #wget -O "$SCRIPT_FOLDER/Certs/roskazna/00B5F132D300000000015A.cer" https://e-trust.gosuslugi.ru/c66253f3-b49c-4aea-b5dc-0ec291e242e4
		# https://e-trust.gosuslugi.ru/#/portal/registry/ufo-certificate-card/13022 #wget -O "$SCRIPT_FOLDER/Certs/roskazna/36ACD45500000000012F.cer" https://e-trust.gosuslugi.ru/247fe5eb-1693-480c-b339-1441e9421e2c
		# https://e-trust.gosuslugi.ru/#/portal/registry/ufo-certificate-card/34208 #wget -O "$SCRIPT_FOLDER/Certs/roskazna/62AB79950000000003B6.cer" https://e-trust.gosuslugi.ru/1cad4c97-19e7-4dfc-80f4-f272c7dad089

		# RosKazna CER / CRT
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/guc2021.cer" "http://crl.roskazna.ru/crl/Корневой сертификат ГУЦ 2021.cer"
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/guc2022.cer" "http://crl.roskazna.ru/crl/Корневой сертификат ГУЦ 2022.cer"
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/guc.crt" "http://crl.roskazna.ru/crl/Корневой сертификат ГУЦ.crt"
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/ucfk.crt" "http://crl.roskazna.ru/crl/Подчиненный сертификат УЦ ФК от 04.07.2017.crt"
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/guc_gost12.crt" "http://crl.roskazna.ru/crl/Корневой сертификат ГУЦ ГОСТ 2012.crt"
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/ucfk_gost12.crt" "http://crl.roskazna.ru/crl/Подчиненный сертификат УЦ ФК ГОСТ 2012.crt"
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2020.crt" "http://crl.roskazna.ru/crl/Подчиненный сертификат УЦ ФК от 05.02.2020.crt"
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2021.crt" http://crl.roskazna.ru/crl/ucfk_2021.crt
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2022.crt" http://crl.roskazna.ru/crl/ucfk_2022.crt
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2022_1.1.crt" http://crl.roskazna.ru/crl/ucfk_2022_1.1.crt
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2023.crt" http://crl.roskazna.ru/crl/ucfk_2023.crt
		wget -O "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2024.crt" http://crl.roskazna.ru/crl/ucfk_2024.crt

		# RosKazna CRL
		wget -O "$SCRIPT_FOLDER/Certs/CRL/vguc1_6.crl" http://reestr-pki.ru/cdp/vguc1_6.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/guc.crl" http://reestr-pki.ru/cdp/guc.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/guc_gost12.crl" http://reestr-pki.ru/cdp/guc_gost12.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/guc2021.crl" http://reestr-pki.ru/cdp/guc2021.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/guc2022.crl" http://reestr-pki.ru/cdp/guc2022.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/ucfk.crl" http://crl.roskazna.ru/crl/ucfk.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/ucfk_gost12.crl" http://crl.roskazna.ru/crl/ucfk_gost12.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/ucfk_2020.crl" http://crl.roskazna.ru/crl/ucfk_2020.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/ucfk_2021.crl" http://crl.roskazna.ru/crl/ucfk_2021.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/ucfk_2022.crl" http://crl.roskazna.ru/crl/ucfk_2022.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/ucfk_2022_1.1.crl" http://crl.roskazna.ru/crl/ucfk_2022_1.1.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/ucfk_2023.crl" http://crl.roskazna.ru/crl/ucfk_2023.crl
		wget -O "$SCRIPT_FOLDER/Certs/CRL/ucfk_2024.crl" http://crl.roskazna.ru/crl/ucfk_2024.crl
		
		sudo chmod -Rv 0777 "$SCRIPT_FOLDER/Certs/"
		echo ""
	else
		echo "*.cer / *.crt / *.crl not downloaded"
	fi

echo -n "install CER/CRT? (y/yes or n/no): "
	read ANSWER
	if [ "$ANSWER" == "y" ] || [ "$ANSWER" == "yes" ] || [ "$ANSWER" == "Y" ];
	then
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/RootCA_RU/4BC6DC14D97010C41A26E058AD851F81C842415A.cer"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/RootCA_RU/AFF05C9E2464941E7EC2AB15C91539360B79AA9D.cer"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/RootCA_RU/9BA648660733ED7A550BCEA03A20E14B8F25C99B.cer"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/RootCA_RU/2F0CB09BE3550EF17EC4F29C90ABD18BFCAAD63A.cer"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/RootCA_RU/1D13121735DD6E1F59EA58C786B8F7E8B7E6E20F.cer"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/RootCA_RU/8CAE88BBFD404A7A53630864F9033606E1DC45E2.cer"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/guc2021.cer"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/guc2022.cer"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/guc.crt"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/ucfk.crt"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/guc_gost12.crt"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/ucfk_gost12.crt"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2020.crt"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2021.crt"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2022.crt"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2022_1.1.crt"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2023.crt"
		sudo /opt/cprocsp/bin/amd64/certmgr -inst -store mRoot -file "$SCRIPT_FOLDER/Certs/roskazna/ucfk_2024.crt"
	else
		echo "*.cer / *.crt not installed"
	fi

echo -n "install CRLs? (y/yes or n/no): "
	read ANSWER
	if [ "$ANSWER" == "y" ] || [ "$ANSWER" == "yes" ] || [ "$ANSWER" == "Y" ];
	then
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/vguc1_6.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/guc.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/guc_gost12.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/guc2021.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/guc2022.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/ucfk.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/ucfk_gost12.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/ucfk_2020.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/ucfk_2021.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/ucfk_2022.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/ucfk_2022_1.1.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/ucfk_2023.crl"
		sudo /opt/cprocsp/bin/amd64/certmgr -install -crl -store mCA -file "$SCRIPT_FOLDER/Certs/CRL/ucfk_2024.crl"
	else
		echo "*.crl not installed"
	fi
