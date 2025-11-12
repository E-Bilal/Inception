FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysqli \
    curl 

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/WPInstaller.sh .

RUN chmod +x WPInstaller.sh
RUN chmod +x /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php

CMD ["./WPInstaller.sh"]

