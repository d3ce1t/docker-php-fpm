# Build this image
```
export PHP_VERSION=7.1.33
export XDEBUG_VERSION=2.9.4
docker build \
    -t d3ce1t/php-fpm:$PHP_VERSION-alpine \
    --build-arg PHP_VERSION \
    --build-arg XDEBUG_VERSION \
    .
```