FROM ubuntu:latest

MAINTAINER Dominic Boisvert <dominic.boisvert@hbarchivistes.qc.ca>

# Variables pour notre dockerfile.
ENV TEMATRES_URL https://codeload.github.com/tematres/TemaTres-Vocabulary-Server/zip/master

ENV TEMATRES_DB_TYPE demo
ENV TEMATRES_DB_NAME tematres
ENV TEMATRES_DB_USER tematres_user
ENV TEMATRES_DB_PASS tematres_pass

# Pour mettre à jour les dépôts et installer les paquets nécessaires.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
  apache2 \
  git \
  mysql-client \
  php5 \
  unzip

# Pour télcharger, placer tematres au bon endroit et donner les bons droits pour le serveur Web.
ADD $TEMATRES_URL /
RUN mkdir /var/www/html/temastres
RUN unzip master
RUN mv TemaTres-Vocabulary-Server-master/ /var/www/html/temastres
RUN rm master
#RUN chown -R www-data:www-data /var/www/html/temastres

# Pour démarrer les services Web.
RUN service apache2 start
#RUN service mysql start

# Pour que notre installation de Tematres soit accessible à 0.0.0.0:80/tematres
EXPOSE 80

# Pour configurer la base de données
ADD setup.sh /setup.sh
RUN chmod u+x /*.sh
RUN ./setup.sh
