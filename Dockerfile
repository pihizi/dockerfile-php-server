FROM debian:7.6
MAINTAINER pihizi@msn.com

RUN apt-get update
# Install PHP
RUN apt-get -y install \
    gcc \
    libxml2-dev \
    libcurl4-gnutls-dev \
    libjpeg-dev \
    libpng-dev \
    libxpm-dev \
    libfreetype6-dev \
    libt1-dev \
    libmcrypt-dev \
    libxslt1-dev \
    libssl-dev \
    libbz2-dev

ADD php.tar /tmp/php/php.tar
WORKDIR /tmp/php
RUN \
    tar -xf php.tar && \
    EXTENSION_DIR=/usr/local/php5/lib/php/extensions/normal ./configure \
        --prefix=/usr/local/php5 \
        --with-config-file-path=/etc/php5/fpm \
        --with-pear \
        --with-gd \
        --with-jpeg-dir \
        --with-png-dir \
        --with-xpm-dir \
        --with-freetype-dir \
        --with-t1lib \
        --enable-exif \
        --with-xsl \
        --with-xmlrpc \
        --with-mcrypt \
        --with-mhash \
        --with-mysql \
        --with-mysqli \
        --with-pdo-mysql \
        --with-openssl \
        --with-curl \
        --with-bz2 \
        --with-fpm-user=www-data \
        --with-fpm-group=www-data \
        --with-gettext \
        --with-zlib \
        --enable-mbstring \
        --enable-fpm \
        --enable-zip \
        --enable-wddx \
        --enable-bcmath \
        --enable-calendar \
        --enable-ftp \
        --enable-soap \
        --enable-sockets \
        --enable-shmop \
        --enable-dba \
        --enable-sysvmsg \
        --enable-sysvsem \
        --enable-sysvshm \
        --enable-cgi \
        --enable-cli

RUN apt-get install make && make && make install

RUN \
    cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm && \
    chmod +x /etc/init.d/php-fpm

WORKDIR /
RUN rm -rf /tmp/php

VOLUME ["/etc/php5"]

# Add Extension

# Install XDebug
# Install PHPUnit
# Install PHP-CS-Fixer

# Install Composer

EXPOSE 9000

CMD ["service php-fpm start"]
