#!/bin/bash

chown -R mysql:mysql /var/lib/mysql

service mariadb start
sleep 0.1 

echo "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME ;" > init.sql
echo "CREATE USER IF NOT EXISTS '$DATABASE_USER'@'%' IDENTIFIED BY '$DATABASE_PASSWORD' ;" >> init.sql
echo "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%' ;" >> init.sql
echo "FLUSH PRIVILEGES;" >> init.sql

mysql < init.sql

service mariadb stop
sleep 0.1

mariadbd #포그라운드로 설정 
