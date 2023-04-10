FROM alpine:3.14
ARG DEBIAN_FRONTEND=noninteractive
RUN apk add --update --no-cache python3 nginx && ln -sf python3 /usr/bin/python 
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools


ENV nginx_vhost /etc/nginx/conf.d/default.conf
ENV nginx_conf /etc/nginx/nginx.conf

COPY ./nginx/default ${nginx_vhost}
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./app /opt/app


RUN pip install -r /opt/app/requirements.txt

COPY ./start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 80 443
CMD ["./start.sh"]