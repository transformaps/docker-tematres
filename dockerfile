FROM ubuntu:latest

MAINTAINER Dominic Boisvert <dominic.boisvert@hbarchivistes.qc.ca>

# Variables pour notre dockerfile.
ENV TEMATRES_URL https://codeload.github.com/tematres/TemaTres-Vocabulary-Server/zip/master
#ENV TEMATRES_DB_TYPE demo
#ENV TEMATRES_DB_NAME tematres
#ENV TEMATRES_DB_USER root
#ENV TEMATRES_DB_PASS
ENV DEBIAN_FRONTEND noninteractive

# Pour mettre à jour les dépôts et installer les paquets nécessaires et faire le ménage.
RUN apt-get update && \
  apt-get -y install \
  apache2 \
  libapache2-mod-php5 \
  mysql-server \
  php-apc \
  php5-mcrypt \
  php5-mysql \
  pwgen \
  supervisor \
  unzip && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*

# Pour télécharger, placer tematres au bon endroit et donner les bons droits pour le serveur Web.
ADD $TEMATRES_URL /var/www/html/
RUN unzip /var/www/html/master &&\
  rm master && \
mv TemaTres-Vocabulary-Server-master tematres && \
chown -R www-data:www-data tematres

# Diverses configurations.
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Ajouter les utilitaires MySQL.
#ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
#RUN chmod 755 /*.sh

# Pour créer notre base de données.
RUN mysql -uroot -e "CREATE DATABASE tematres CHARACTER SET utf8 COLLATE utf8_general_ci;"

# Pour que notre installation de Tematres soit accessible à 0.0.0.0:80/tematres
EXPOSE 80 3306

CMD ["/run.sh"]
