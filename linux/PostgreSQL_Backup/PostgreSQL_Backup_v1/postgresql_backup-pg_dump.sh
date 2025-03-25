#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# postgresql_backup-pg_dump.sh
# Author: @usrunsudo

DIR="/mnt/raid/1C/1c_backup/pg_dump/";
DAEMON_1C="srv1cv8-8.3.25.1394@default.service";
DAEMON_PG="postgrespro-1c-15.service";
DATABASE_0="1c_template_empty";
DATABASE_1="buh";
DATABASE_2="zup";
DATABASE_3="docob";


# Создание лог-файла
touch "$DIR""pg_dump""_$(date +%Y-%m-%d).log"
echo "---------- $(date +%Y-%m-%d_%H-%M-%S) ----------" >> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"
echo "" >> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"



# Остановка службы 1С
systemctl stop $DAEMON_1C &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"

# Остановка и запуск службы PostgreSQL
systemctl stop $DAEMON_PG &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"
sleep 60s &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"
systemctl start $DAEMON_PG &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"

# Выгрузка дампа базы в локальную папку
# Подключение к базе PostgreSQL происходит под пользователем "postgres"
# pg_dump -h localhost -Upostgres -w -Ft -b -EUTF8 -v -f "$DIR""$DATABASE_1""_$(date +%Y-%m-%d).psql" "$DATABASE_1"
sudo -u postgres pg_dump -w -Ft -b -EUTF8 -v -f "$DIR""$DATABASE_1/""$DATABASE_1""_$(date +%Y-%m-%d).psql" "$DATABASE_1" &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"
sudo -u postgres pg_dump -w -Ft -b -EUTF8 -v -f "$DIR""$DATABASE_2/""$DATABASE_2""_$(date +%Y-%m-%d).psql" "$DATABASE_2" &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"
sudo -u postgres pg_dump -w -Ft -b -EUTF8 -v -f "$DIR""$DATABASE_3/""$DATABASE_3""_$(date +%Y-%m-%d).psql" "$DATABASE_3" &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"

# Перезапуск службы PostgreSQL
systemctl restart $DAEMON_PG &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"

# Запуск Службы 1С
systemctl start $DAEMON_1C &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"

# Сжатие дампа базы в локальной папке
bzip2 -z "$DIR""$DATABASE_1/""$DATABASE_1""_$(date +%Y-%m-%d).psql" &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"
bzip2 -z "$DIR""$DATABASE_2/""$DATABASE_2""_$(date +%Y-%m-%d).psql" &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"
bzip2 -z "$DIR""$DATABASE_3/""$DATABASE_3""_$(date +%Y-%m-%d).psql" &>> "$DIR""pg_dump""_$(date +%Y-%m-%d).log"
