FROM nginx:1.17.1-alpine
COPY src /usr/share/nginx/html
COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY src /usr/share/nginx/html

 