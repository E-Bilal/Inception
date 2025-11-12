FROM debian:bullseye

RUN apt-get update && apt-get install nginx -y

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/nginxscript.sh .

RUN chmod +x nginxscript.sh

CMD ["./nginxscript.sh"]
 
