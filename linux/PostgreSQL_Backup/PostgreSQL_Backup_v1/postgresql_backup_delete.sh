#!/bin/sh
# PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# postgresql_backup_delete.sh
# Author: @usrunsudo

clear
sleep 1s

DAY_MIN=35
DIR_pg_basebackup="/mnt/raid/1C/1c_backup/pg_basebackup/"
DIR_pg_dump="/mnt/raid/1C/1c_backup/pg_dump/"
DIR_1c_files="/mnt/raid/1C/1c_backup/1c_files/"

# find $DIR -type f -mtime +$DAY #-delete

echo "Select files older than N days."
echo -n "Enter the value of the variable 'N': "
	read DAY
	if (( "$DAY" >= "$DAY_MIN" ))
	then
		echo -n ""
	else
		DAY=$DAY_MIN
		echo "Minimum number of days before files are deleted = $DAY_MIN. 'N' = $DAY_MIN"
	fi

echo ""
echo -e "\033[41m===== OLD FILES from '/mnt/raid/1C/1c_backup/' - Files older than $DAY days =====\033[0m"
echo ""

echo -e "\033[41mfind $DIR_pg_basebackup -type f -mtime +$DAY\033[0m"
find $DIR_pg_basebackup -type f -mtime +$DAY
echo ""

echo -e "\033[41mfind $DIR_pg_basebackup -type d -mtime +$DAY\033[0m"
find $DIR_pg_basebackup -type d -mtime +$DAY
echo ""

echo -e "\033[41mfind $DIR_pg_dump -type f -mtime +$DAY\033[0m"
find $DIR_pg_dump -type f -mtime +$DAY
echo ""

echo -e "\033[41mfind $DIR_1c_files -type f -mtime +$DAY\033[0m"
find $DIR_1c_files -type f -mtime +$DAY
echo ""

echo ""
echo -n "Delete files older than $DAY days? (Type 'yes' to confirm): "
	read ANSWER
	if [ "$ANSWER" == "yes" ]
	then
		find $DIR_pg_basebackup -type f -mtime +$DAY -delete
		find $DIR_pg_basebackup -type d -mtime +$DAY -delete
		find $DIR_pg_dump -type f -mtime +$DAY -delete
		find $DIR_1c_files -type f -mtime +$DAY -delete
		echo ""
		echo -e "\033[41mOld files have been deleted\033[0m"
	else
		echo -e "\033[41mOld files are not deleted\033[0m"
	fi
