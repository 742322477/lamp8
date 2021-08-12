FROM ubuntu:20.04

ENV TZ=America/Bogota
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update -y

RUN apt install apache2 -y
RUN a2enmod rewrite

RUN apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y
RUN apt update -y

RUN apt-get install mariadb-common mariadb-server mariadb-client -y

RUN apt install php8.0 libapache2-mod-php php-mysql -y
RUN apt install curl php-cli php-mbstring git unzip -y
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN apt install php-xml -y
RUN mkdir /var/www/app

VOLUME /var/www/app
VOLUME /var/lib/mysql
VOLUME /etc/apache2

EXPOSE 80
EXPOSE 443

CMD apachectl -D FOREGROUND