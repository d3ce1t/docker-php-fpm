# PHP-FPM Docker Image with Opcache and XDebug

This image contains PHP-FPM with Opcache and XDebug installed. Configuration is production ready: Opcache enabled by default but not XDebug. For development, disable Opcache by removing `/usr/local/etc/php/conf.d/docker-php-ext-opcache.ini`.

## Build this image
```
docker build -t d3ce1t/php-fpm:7.2.34-alpine .
```

## Create your own image for development
```docker
FROM d3ce1t/php-fpm
RUN docker-php-ext-enable xdebug \
    && rm /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
```
