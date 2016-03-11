FROM gogcom/docker-git

MAINTAINER GOG Team <webdev@gog.com>

RUN apt-get update
RUN apt-get install -y --force-yes wget

RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
RUN echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
RUN wget https://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg
RUN apt-get update

RUN apt-get install -y --force-yes php7.0 php7.0-fpm php7.0-mcrypt php7.0-mysql php7.0-apcu php7.0-gd php7.0-imagick php7.0-curl php7.0-intl php7.0-xdebug php7.0-memcached

RUN apt-get install -y curl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

ADD parameters.ini /etc/php/7.0/fpm/conf.d/
ADD parameters.ini /etc/php/7.0/cli/conf.d/

ADD application.pool.conf /etc/php/7.0/fpm/pool.d/

RUN usermod -u 1000 www-data

RUN mkdir -p /run/php

CMD ["php-fpm7.0", "-F"]

EXPOSE 9000