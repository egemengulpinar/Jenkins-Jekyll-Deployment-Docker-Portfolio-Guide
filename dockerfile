FROM nginx:1.17.1-alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY src /usr/share/nginx/html
RUN nginx -t
RUN nginx -s reload