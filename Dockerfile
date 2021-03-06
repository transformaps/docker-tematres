# Pour le cours ARV3054, idéalement vous devrions utiliser la fonctionnalité de liaison entre les contenants.

FROM ubuntu:14.04

MAINTAINER Dominic Boisvert <dominic.boisvert.1@humontreal.ca>

# Variables pour notre dockerfile.
ENV TEMATRES_URL=https://codeload.github.com/tematres/TemaTres-Vocabulary-Server/zip/master
ENV DEBIAN_FRONTEND=noninteractive

# Pour mettre à jour les dépôts et installer les paquets nécessaires et faire le ménage.
RUN apt-get update && \
  apt-get -y install \
  apache2 \
  libapache2-mod-php5 \
  mysql-server \
  php-apc \
  php5-mcrypt \
  php5-mysql \
  supervisor \
  unzip \
  wget && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*

# Pour télécharger, placer tematres au bon endroit et donner les bons droits pour le serveur Web.
RUN mkdir -p /var/www/html/ \
    && wget $TEMATRES_URL && \
    unzip master -d /var/www/html/ && \
    mv /var/www/html/TemaTres-Vocabulary-Server-master /var/www/html/tematres && \
    chown -R www-data:www-data /var/www/html/tematres

# Divers scripts et configurations.
ADD scripts/start-apache2.sh /start-apache2.sh
ADD scripts/start-mysqld.sh /start-mysqld.sh
ADD scripts/create-db.sh /create-db.sh
ADD scripts/run.sh /run.sh
RUN chmod 755 /*.sh
ADD conf/my.cnf /etc/mysql/conf.d/my.cnf
ADD conf/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD conf/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Pour que notre installation de Tematres soit accessible à 0.0.0.0:80/tematres
EXPOSE 80 3306

# Volume pour partager des fichiers entre le host et le conteneur Docker.
#RUN mkdir /partage
#VOLUME ["/partage"]

#CMD ["/run.sh"]
