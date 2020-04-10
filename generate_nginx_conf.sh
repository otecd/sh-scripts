#!/usr/bin/env bash

if [ "$1" != "" ]; then
  if ! type envsubst > /dev/null; then
    apt-get update
    apt-get install gettext-base
  fi

  export DOLLAR='$'
  envsubst < $1 > ./$DOMAIN.conf
  if [ "$2" != "" ]; then
    mv ./$DOMAIN.conf $2
  else
    chown root:root ./$DOMAIN.conf
    mv ./$DOMAIN.conf /etc/nginx/sites-available/
    ln -s /etc/nginx/sites-available/$DOMAIN.conf /etc/nginx/sites-enabled/
    nginx -t
    service nginx reload
  fi
else
  echo "В качестве первого аргумента следует задать путь к файлу nginx template"
fi
