FROM ubuntu:latest

MAINTAINER Dominic Boisvert <dominic.boisvert@hbarchivistes.qc.ca>

# Variables pour notre dockerfile.
ENV TEMATRES_URL https://codeload.github.com/tematres/TemaTres-Vocabulary-Server/zip/master
ENV TEMATRES_DB_TYPE demo
ENV TEMATRES_DB_NAME tematres
ENV TEMATRES_DB_USER root
ENV TEMATRES_DB_PASS 123456

# Pour mettre à jour les dépôts et installer les paquets nécessaires et faire le ménage.
RUN apt-get update
RUN apt-get -yq install --no-install-recommends \
  apache2 \
  git \
  mysql-server \
  php5 \
  unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*

ADD mysql_run.sh /tmp/mysql_run.sh
RUN chmod +x /tmp/mysql_run.sh
RUN ./tmp/mysql_run.sh

# Notre répertoire de travail.
WORKDIR /var/www/html

# Pour télécharger, placer tematres au bon endroit et donner les bons droits pour le serveur Web.
ADD $TEMATRES_URL /var/www/html/
RUN unzip master
RUN rm master
RUN mv TemaTres-Vocabulary-Server-master tematres
RUN chown -R www-data:www-data tematres

# Pour configurer l'accès à la base de données.
#RUN sed -i "s/$DBCFG["DBPass"] = "";/$DBCFG["DBPass"] = "123456";/g" /vocab/db.tematres.php

# Pour démarrer le serveur Web.
#RUN service apache2 start

# Pour que notre installation de Tematres soit accessible à 0.0.0.0:80/tematres
EXPOSE 80
