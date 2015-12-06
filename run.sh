#!/bin/bash

#echo "Pour créer notre base de données."
#mysql -uroot -e "CREATE DATABASE tematres CHARACTER SET utf8 COLLATE utf8_general_ci;"

exec supervisord -n
