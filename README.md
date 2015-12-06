# docker-tematres
Dockerfile pour Tematres

## Utiliser ce projet

Ce projet est développé et maintenu pour faciliter la prise en main de logiciels dans le cadre du cours ARV3054 - Gestion des archives numériques offert par l'[École de bibliothéconomie et des sciences de l'information] (http://www.ebsi.umontreal.ca/accueil/) de l'[Université de Montrêal] (http://www.umontreal.ca).

Pour utiliser ce projet vous devez installer [Docker] (http://docs.docker.com/mac/started/) (anglais) pour Windows, Mac OS X ou Linux.

## Instructions

Les instructions ont été développées et testées sous Linux. Les instructions Windows et Mac OS X suivront.

### Installation Linux

Les instructions suivantes permettent d'installer et de faire la configuration initile.

1. Télécharger le zip de ce projet
2. Pour lancer l'installation : `$ sudo docker build -t arv3054/tematres .`
3. Pour lancer le contenant : `$ sudo docker run -i -t -d -p 80:80 --name tematres arv3054/tematres`
4. Puis pour créer la base de données faire : `$ sudo docker exec -i -t tematres /create-tematres-db.sh`

Vous pouvez maintenant visiter votre thésaurus à l'URL : `0.0.0.0/tematres`

Vous pouvez arrêter votre contenant avec la commande suivante : `$ sudo docker stop tematres`

### Démarrer le contenant existant

Si vous souhaitez démarrer votre contenant (que vous avez arrêté avec la commande `stop`) : `$ sudo docker start tematres`

### Configuration au premier démarrage de Tematres

Lors du premier démarrage de Tematres, et à toutes les fois que vous aurez effacé le contenant (avec la commande `$ sudo docker rm tematres`) vous devrez procéder à la configuration initiale de Tematres[1].

1. Dans votre navigateur, visiter l'URL `0.0.0.0/tematres`
2. Sélectionner la langue (linguo) française
3. Le nom du site est : Thésaurus - ARV3054
3. Le nom d'usager par défaut est « docker » (sans les guillements)
4. Le mot de passe par défaut est  « docker » (sans les guillements)
5. L'adresse courriel de l'usager est  « docker@localhost.local » (sans les guillements)

[1] La configuration est nécessaire, mais vous pouvez insrire les informations de votre choix.
