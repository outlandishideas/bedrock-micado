FROM outlandish/nginx-vts

COPY docker/web/site.template /etc/nginx/conf.d/site.template
COPY docker/web/vts.conf /etc/nginx/conf.d/vts.conf

COPY . /var/www/html
COPY docker/web/entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

ENTRYPOINT entrypoint