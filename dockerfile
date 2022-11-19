FROM nginx:1.17.1-alpine
RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf
#COPY conf /etc/nginx
COPY /conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY src /usr/share/nginx/html
