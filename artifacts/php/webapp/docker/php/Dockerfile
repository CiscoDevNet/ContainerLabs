FROM bitnami/php-fpm:7.1

# Copy the php config file
COPY ./docker/php/php-fpm.conf /etc/php/7.1/fpm/pool.d/www.conf

# Copy the application code
COPY . /code


VOLUME ["/code"]
