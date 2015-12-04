#!/bin/bash

# pull the latest images
echo "Pulling MySQL image"
docker pull mysql

# Contruire notre contenant tematres.
echo "Contruire notre contenant tematres."
docker build -t arv3054/tematres .

echo "Starting MySQL instance in background"
docker run -d \
  -p 3306:3306 \
  --name mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e MYSQL_DATABASE=tematres \
  -e MYSQL_USER=tematres_user \
  -e MYSQL_PASSWORD=tematres_pass \
  mysql

# give mysql time to start
echo "Waiting for MySQL to initialize"
sleep 30

echo "Démarrage de tematres en tâche de fonds."
docker run -d \
  -p 80:80 \
  --name tematres-test \
  -e TEMATRES_DB_TYPE=mysql \
  --link mysql:db \
  arv3054/tematres
