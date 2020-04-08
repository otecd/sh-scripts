#!/usr/bin/env bash

if [ "$1" != "" ]; then
  export DOLLAR='$'
  envsubst < $1 > ./$DOMAIN.conf
  if [ "$2" != "" ]; then
    sudo mv ./$DOMAIN.conf $2
  else
    sudo chown root:root ./$DOMAIN.conf
    sudo mv ./$DOMAIN.conf /etc/nginx/sites-available/
    sudo ln -s /etc/nginx/sites-available/$DOMAIN.conf /etc/nginx/sites-enabled/
    sudo nginx -t
    sudo service nginx reload
  fi
else
  echo "В качестве первого аргумента следует задать путь к файлу nginx template"
fi
