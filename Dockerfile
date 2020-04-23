FROM php:7.2.29-fpm-alpine3.10
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
ENV XDEBUG_VERSION=2.9.4
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
    && docker-php-ext-install intl bcmath pdo_mysql gd zip opcache \
    && pecl install xdebug-$XDEBUG_VERSION \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && docker-php-source delete \
    && apk del .build-deps \
    && rm -rf /tmp/pear ~/.pearrc