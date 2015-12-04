#!/bin/bash

# pull the latest images
#echo "Pulling MySQL image"
#docker pull mysql

#echo "Builder or container"
#docker build -t dominic/tematres-test .

echo "Starting MySQL instance in background"
docker run -d \
  -p 3306:3306 \
  --name mysql-test \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e MYSQL_DATABASE=tematres \
  -e MYSQL_USER=tematres \
  -e MYSQL_PASSWORD=tematres \
  mysql

# give mysql time to start
echo "Waiting for MySQL to initialize"
sleep 30

# Start Tematres container
echo "Starting Tematres instance with bash open"
docker run -i -t \
  --name tematres-test \
  -p 80:80 \
  -e TEMATRES_DB_TYPE=mysql \
  --link mysql:db \
  ubuntu:latest
