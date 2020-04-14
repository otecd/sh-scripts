#!/usr/bin/env bash

for arg in "$@"; do
  kk=$(echo $arg | cut -f1 -d=)
  vv=$(echo $arg | cut -f2 -d=)
  case "$kk" in
    -d|--domain) domain=${vv} ;;
    -p|--port) port=${vv} ;;
    -u|--user) user=${vv} ;;
    -h|--host) host=${vv} ;;
    *) printf "Error: Invalid argument $kk\n"; exit 1
  esac
done

mkdir -p ~/.ssh
[[ -f /.dockerenv ]] && echo -e "Host $host\n\tHostName $domain\n\tPort $port\n\tUser $user\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
chmod -R 600 ~/.ssh

