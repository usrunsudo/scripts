#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# postgresql_backup-pg_basebackup.sh
# Author: @usrunsudo

DIR="/mnt/raid/1C/1c_backup/pg_basebackup/";
DAEMON_1C="srv1cv8-8.3.25.1394@default.service";
DAEMON_PG="postgrespro-1c-15.service";

# Создание лог-файла
touch "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"
echo "---------- $(date +%Y-%m-%d_%H-%M-%S) ----------" >> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"
echo "" >> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"

# Остановка службы 1С
systemctl stop $DAEMON_1C &>> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"

# Остановка и запуск службы PostgreSQL
systemctl stop $DAEMON_PG &>> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"
sleep 60s &>> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"
systemctl start $DAEMON_PG &>> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"

# Создание бекапа кластера PostgreSQL
# sudo -u usr1cv8 pg_basebackup -D - -Ft -P | bzip2 > "$DIR""pg_basebackup_$(date +%Y-%m-%d).tar.bz2" &>> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"
sudo -u usr1cv8 pg_basebackup -D "$DIR""pg_basebackup_$(date +%Y-%m-%d)" -Ft -P &>> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"

# Создание бэкапа прикрепленных файлов 1С
cd /mnt/raid/1C/1c_files/
tar -cvf "files_buh_$(date +%Y-%m-%d).tar" ./buh/
tar -cvf "files_zup_$(date +%Y-%m-%d).tar" ./zup/
tar -cvf "files_docob_$(date +%Y-%m-%d).tar" ./docob/
mv "files_buh_$(date +%Y-%m-%d).tar" /mnt/raid/1C/1c_backup/1c_files/files_buh/
mv "files_zup_$(date +%Y-%m-%d).tar" /mnt/raid/1C/1c_backup/1c_files/files_zup/
mv "files_docob_$(date +%Y-%m-%d).tar" /mnt/raid/1C/1c_backup/1c_files/files_docob/
cd $HOME

# Перезапуск службы PostgreSQL
systemctl restart $DAEMON_PG &>> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"

# Запуск Службы 1С
systemctl start $DAEMON_1C &>> "$DIR""pg_basebackup""_$(date +%Y-%m-%d).log"
