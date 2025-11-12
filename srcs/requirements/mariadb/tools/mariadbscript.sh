#!/bin/bash

export ROOTPASSWORD=$(cat /run/secrets/rootpassword)

cd /etc/mysql
touch init.sql

echo "CREATE DATABASE IF NOT EXISTS wordpress;" >> init.sql
echo "CREATE USER IF NOT EXISTS '$ROOTUSER'@'%' IDENTIFIED BY '$ROOTPASSWORD';" >> init.sql
echo "GRANT ALL PRIVILEGES ON *.* TO '$ROOTUSER'@'%' WITH GRANT OPTION;" >> init.sql
echo "FLUSH PRIVILEGES;" >> init.sql


chmod 644 init.sql
echo "Initialization script created successfully."

mkdir /run/mysqld
exec mysqld
