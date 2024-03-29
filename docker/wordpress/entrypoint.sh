#!/bin/sh

export FPM_PM_MAX_CHILDREN=${FPM_PM_MAX_CHILDREN-5}
export FPM_PM_START_SERVERS=${FPM_PM_START_SERVERS-2}
export FPM_PM_MIN_SPARE_SERVERS=${FPM_PM_MIN_SPARE_SERVERS-1}
export FPM_PM_MAX_SPARE_SERVERS=${FPM_PM_MAX_SPARE_SERVERS-3}
export FPM_PM_MAX_REQUESTS=${FPM_PM_MAX_REQUESTS-500}

envsubst '$FPM_PM_MAX_CHILDREN $FPM_PM_START_SERVERS $FPM_PM_MIN_SPARE_SERVERS $FPM_PM_MAX_SPARE_SERVERS $FPM_PM_MAX_REQUESTS' < /usr/local/etc/php-fpm.d/www.template > /usr/local/etc/php-fpm.d/www.conf

php-fpm_exporter server &

php-fpm