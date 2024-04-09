FROM php:8.3-apache

# Update and upgrade packages
RUN apt-get update \
    && apt-get upgrade -y

# Install system dependencies
RUN apt-get install -y libicu-dev

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-install pdo_mysql mysqli && docker-php-ext-enable pdo_mysql

RUN apt-get install git unzip -y

#compose install

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" 
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" 
RUN php composer-setup.php 
RUN php -r "unlink('composer-setup.php');" 
RUN mv composer.phar /usr/local/bin/composer

RUN a2enmod rewrite

EXPOSE 80