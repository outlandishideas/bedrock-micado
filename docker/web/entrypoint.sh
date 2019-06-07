#!/bin/sh

envsubst '$NGINX_PORT $NGINX_HOST $FPM_HOST $FPM_PORT' < /etc/nginx/conf.d/site.template > /etc/nginx/conf.d/default.conf
exec nginx -g 'daemon off;'