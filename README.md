# docker-tematres
Dockerfile pour Tematres

## Utiliser ce projet

Ce projet est développé et maintenu pour faciliter la prise en main de logiciels dans le cadre du cours ARV3054 - Gestion des archives numériques offert par l'[École de bibliothéconomie et des sciences de l'information] (http://www.ebsi.umontreal.ca/accueil/) de l'[Université de Montrêal] (http://www.umontreal.ca).

Pour utiliser ce projet vous devez installer [Docker] (http://docs.docker.com/mac/started/) (anglais) pour Windows, Mac OS X ou Linux.

## Instructions

Les instructions ont été développées et testées sous Linux. Les instructions Windows et Mac OS X suivront.

### Dockerfile

Pour lancer l'installation.

sudo docker build -t arv3054/tematres .

### Pour lancer le contenant

Au premier démarrage, utiliser la commande suivante : sudo docker run -i -t -d tematres ubuntu:latest

Par la suite : sudo docker start tematres

Pour arrêter le contenant : sudo docker stop tematres

### Pour le premier lancement de Tematres

Lors du premier lancement de Tematres, et à toutes les fois que vous aurez effacé le contenant (avec la commande sudo docker rm tematres) vous devrez procéder à la configuration initiale de Tematres.

1. Dans votre navigateur, visiter l'URL 0.0.0.0/tematres
2. Sélectionner la langue (linguo) française
3. Le nom d'usager par défaut est « docker » (sans les guillements)
4. Le mot de passe par défaut est  « docker » (sans les guillements)
5. L'adresse courriel de l'usager est  « docker@localhost.local » (sans les guillements)
