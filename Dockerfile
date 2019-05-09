FROM nginx:1.16.0-alpine-perl

# Try printenv in an attached shell to a container and see if foo=bar
ENV foo=bar

RUN apk add --no-cache --update\
  bash \
  php7 \
  php7-common \
  php7-fpm \
  php7-mysqli

# Copy files from your own system to the image/ for nginx
COPY index.html /usr/share/nginx/html/index.html
COPY info.php /usr/share/nginx/html/info.php
COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx.conf /etc/nginx/nginx.conf

CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'