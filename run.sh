#!/bin/bash

echo "Ici on démarre le serveur Web."
service apache2 restart

echo "Ici on démarre le serveur MySQL."
service mysql restart

# give mysql time to start
echo "Waiting for MySQL to initialize"
sleep 30

echo "Pour créer notre base de données."
mysql -uroot -e "CREATE DATABASE tematres CHARACTER SET utf8 COLLATE utf8_general_ci;"

exec supervisord -n
