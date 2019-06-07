FROM outlandish/wordpress AS build

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN chown www-data:www-data /var/www/html

COPY --chown=www-data:www-data composer.json /var/www/html
COPY --chown=www-data:www-data composer.lock /var/www/html

USER www-data

RUN composer install

FROM outlandish/wordpress

COPY --from=build --chown=www-data:www-data /var/www/html /var/www/html
COPY --chown=www-data:www-data ./ /var/www/html
