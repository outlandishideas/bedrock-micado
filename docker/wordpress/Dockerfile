FROM outlandish/wordpress AS build

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN chown www-data:www-data /var/www/html

COPY --chown=www-data:www-data composer.json /var/www/html
COPY --chown=www-data:www-data composer.lock /var/www/html

USER www-data

RUN composer install

FROM outlandish/wordpress

COPY --from=hipages/php-fpm_exporter /php-fpm_exporter /usr/bin/php-fpm_exporter
EXPOSE 9253

RUN apk add --no-cache gettext

COPY ./docker/wordpress/www.template /usr/local/etc/php-fpm.d/www.template
COPY ./docker/wordpress/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

COPY --from=build --chown=www-data:www-data /var/www/html /var/www/html

COPY --chown=www-data:www-data ./ /var/www/html
