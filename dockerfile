FROM dockie/lamp

MAINTAINER Dominic Boisvert <dominic.boisvert@hbarchivistes.qc.ca>

# Variables pour notre dockerfile.
ENV TEMATRES_URL https://codeload.github.com/tematres/TemaTres-Vocabulary-Server/zip/master
ENV TEMATRES_DB_TYPE demo
ENV TEMATRES_DB_NAME tematres
ENV TEMATRES_DB_USER root
ENV TEMATRES_DB_PASS root

# Pour mettre à jour les dépôts et installer les paquets nécessaires et faire le ménage.
RUN apt-get update
RUN apt-get -yq install --no-install-recommends \
  unzip && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*

# Pour télécharger, placer tematres au bon endroit et donner les bons droits pour le serveur Web.

ADD $TEMATRES_URL /var/www/html/
RUN unzip /var/www/html/master
#RUN rm master
RUN mv TemaTres-Vocabulary-Server-master tematres
RUN chown -R www-data:www-data tematres

# Pour configurer l'accès à la base de données.
cat /var/www/html/tematres/vocab/db.tematres.php | \
sed -e 's/$DBCFG["DBPass"] = ""/;/$DBCFG["DBPass"] = "root"/' > /var/www/html/tematres/vocab/db.tematres.php

# Pour démarrer le serveur Web.
RUN service apache2 start && \
    service mysql start

# Nous allons maintenant créer notre base de données. Notez que la pratique d'utiliser le mot de passe dans la commande n'est pas sécuritaire, mais ici ce n'est pas important.
RUN mysql -uroot -proot -e "CREATE DATABASE tematres CHARACTER SET utf8 COLLATE utf8_bin;"

# Pour que notre installation de Tematres soit accessible à 0.0.0.0:80/tematres
EXPOSE 80
