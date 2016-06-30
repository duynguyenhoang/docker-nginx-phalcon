FROM ubuntu:14.04.4

MAINTAINER Duy Nguyen <nhduy88@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install git nginx nginx-extras php5-dev php5-fpm libpcre3-dev gcc make php5-mysql php5-mcrypt php5-curl php5-imagick php5-gd php5-geoip php5-xdebug autoconf g++ make openssl libssl-dev libcurl4-openssl-dev libcurl4-openssl-dev pkg-config libsasl2-dev php-pear

RUN mkdir /var/www
RUN echo "<?php phpinfo(); ?>" > /var/www/index.php

# Composer
RUN curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Phalcon
RUN git clone --depth=1 http://github.com/phalcon/cphalcon.git
RUN cd cphalcon/build && ./install;

RUN echo 'extension=phalcon.so' >> /etc/php5/fpm/conf.d/30-phalcon.ini
RUN echo 'extension=phalcon.so' >> /etc/php5/cli/conf.d/30-phalcon.ini

# Mongodb Ext
RUN pecl install mongodb

RUN echo 'extension=mongodb.so' >> /etc/php5/fpm/conf.d/30-mongodb.ini
RUN echo 'extension=mongodb.so' >> /etc/php5/cli/conf.d/30-mongodb.ini

# Config nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD default /etc/nginx/sites-available/default
ADD default-ssl /etc/nginx/sites-enabled/default-ssl

ADD server.crt /etc/nginx/ssl/
ADD server.key /etc/nginx/ssl/

#PHPUnit
RUN curl https://phar.phpunit.de/phpunit.phar -O
RUN mv phpunit.phar /usr/local/bin/phpunit
RUN chmod +x /usr/local/bin/phpunit

#
RUN apt-get clean
ENV DEBIAN_FRONTEND dialog

EXPOSE 80

CMD service php5-fpm start && nginx
