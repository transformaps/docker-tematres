#!/bin/bash

# pull the latest images
echo "Pulling MySQL image"
docker pull mysql

#echo "Pulling latest ArchivesSpace build image"
#docker pull lyrasis/archivesspace
echo "Démarrer le contenant temastres."
#docker start tematres-test

echo "Starting MySQL instance in background"
docker run -d \
  -p 3306:3306 \
  --name mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e MYSQL_DATABASE=tematres \
  -e MYSQL_USER=temastres_user \
  -e MYSQL_PASSWORD=temastres_pass \
  mysql

# give mysql time to start
echo "Waiting for MySQL to initialize"
sleep 30

echo "Démarrage de tematres en tâche de fonds."
docker run --name tematres-test -d \
  -p 80:80 \
  -e TEMATRES_DB_TYPE=mysql \
  --link mysql:db \
  7a0c3a3f5ec3
