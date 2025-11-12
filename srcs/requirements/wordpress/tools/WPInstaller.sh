#!/bin/bash
export ROOTPASSWORD=$(cat /run/secrets/rootpassword)
export ADMINPASSWORD=$(cat /run/secrets/adminpassword)
export AUTHORPASSWORD=$(cat /run/secrets/authorpassword)

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar


chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html

wp core download  --allow-root
wp config create --dbname=wordpress --dbuser=$ROOTUSER --dbpass=$ROOTPASSWORD --dbhost=mariadb --allow-root
wp core install --url=$DOMAINNAME  --title=inception --admin_user=$ADMINUSER --admin_password=$ADMINPASSWORD --admin_email=yuiop@example.com --allow-root
wp user create $AUTHORUSER author@example.com --user_pass=$AUTHORPASSWORD --role=author --allow-root

exec php-fpm7.4 -F

