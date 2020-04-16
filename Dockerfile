ARG PHP_VERSION=7.1.33
FROM php:${PHP_VERSION}-fpm-alpine3.10
ARG XDEBUG_VERSION
ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkgconf \
		re2c \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        freetype-dev \
        libxpm-dev \
        zlib-dev \
        icu-dev
ENV XDEBUG_VERSION ${XDEBUG_VERSION}
ENV COMPOSER_CACHE_DIR=/dev/null
RUN pecl channel-update pecl.php.net \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && apk add --no-cache freetype libpng libjpeg-turbo libwebp libxpm icu zlib composer \
    && docker-php-ext-configure gd \
        --with-gd \
        --with-webp-dir \
        --with-jpeg-dir \
        --with-png-dir \
        --with-zlib-dir \
        --with-xpm-dir \
        --with-freetype-dir \
    && docker-php-ext-install intl bcmath pdo_mysql gd zip \
    && pecl install xdebug-$XDEBUG_VERSION \
    && docker-php-ext-enable xdebug \
    && docker-php-source delete \
    && apk del .build-deps \
    && rm -rf /tmp/pear ~/.pearrc