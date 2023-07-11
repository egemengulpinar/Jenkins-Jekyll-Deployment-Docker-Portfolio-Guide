FROM nginx:latest
COPY src/_site /usr/share/nginx/html
#COPY default.conf /etc/nginx/conf.d/
 # bundle install
 # bundle exec jekyll serve
