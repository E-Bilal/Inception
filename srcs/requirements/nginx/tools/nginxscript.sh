#!/bin/bash

mkdir etc/ssl

cp /run/secrets/nginx.key /etc/ssl/nginx.key
cp /run/secrets/nginx.crt /etc/ssl/nginx.crt

chmod 600 /etc/ssl/nginx.key
chmod 600 /etc/ssl/nginx.crt

exec "nginx" "-g" "daemon off;"
