FROM php:7.3.26-fpm-alpine3.12
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
        libzip-dev \
        icu-dev
ENV XDEBUG_VERSION=2.9.8
ENV COMPOSER_CACHE_DIR=/dev/null
RUN pecl channel-update pecl.php.net \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && apk add --no-cache freetype libpng libjpeg-turbo libwebp libxpm icu zlib libzip \
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
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --version=2.0.9 \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && docker-php-source delete \
    && apk del .build-deps \
    && rm -rf /tmp/pear ~/.pearrc