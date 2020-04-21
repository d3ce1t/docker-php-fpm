# PHP-FPM Docker Image with XDebug

This image contains PHP-FPM with XDebug installed. However, it is not enabled by default.

## Build this image
```
docker build -t d3ce1t/php-fpm:7.1.33-alpine .
```

## Use as base image
```docker
FROM d3ce1t/php-fpm
RUN docker-php-ext-enable xdebug
```