FROM php:8.1.21-fpm

ARG CACHEBUST=1.1

RUN apt-get update -y

RUN apt-get install -y libpng-dev postgresql libpq-dev
RUN docker-php-ext-install mysqli pgsql  pdo pdo_mysql pdo_pgsql

# RUN apt-get install -y sendmail
RUN apt-get install -y libpng-dev libcurl4-openssl-dev  zlib1g-dev  libonig-dev libzip-dev 

RUN docker-php-ext-install zip gd iconv mbstring

RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install curl dom xml zip simplexml
RUN docker-php-ext-install soap

RUN apt-get install -q -y ssmtp mailutils libicu-dev \ 
&& docker-php-ext-configure intl \
&& docker-php-ext-install intl



RUN apt install -y libmagickwand-dev  exiftool && \
    pecl install imagick && docker-php-ext-enable imagick && docker-php-ext-install exif && docker-php-ext-enable exif


RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache

RUN pecl install redis && docker-php-ext-enable redis
RUN  rm -rf /var/lib/apt/lists/*

# for debugging and develop
# RUN pecl install xdebug && docker-php-ext-enable xdebug


RUN echo "file_uploads = On\n" \
         "memory_limit = 500M\n" \
         "upload_max_filesize = 500M\n" \
         "post_max_size = 500M\n" \
         "max_execution_time = 300\n" \
         "max_input_vars = 5000\n"\
         > /usr/local/etc/php/conf.d/uploads.ini
