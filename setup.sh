#!/bin/bash

if [[ "$TEMASTRES_DB_TYPE" == "mysql" ]]; then
  echo "AppConfig[:db_url] = 'jdbc:mysql://$DB_PORT_3306_TCP_ADDR:3306/$TEMASTRES_DB_NAME?user=$TEMASTRES_DB_USER&password=$TEMASTRES_DB_PASS&useUnicode=true&characterEncoding=UTF-8'" \
    >> /archivesspace/config/config.rb
  /archivesspace/scripts/setup-database.sh
fi
