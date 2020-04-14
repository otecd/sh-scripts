#!/usr/bin/env bash

echo $@

for arg in "$@"; do
  kk=$(echo $arg | cut -f1 -d=)
  vv=$(echo $arg | cut -f2 -d=)
  case "$kk" in
    -d|--domain) domain=${vv} ;;
    -p|--port) port=${vv} ;;
    -u|--user) user=${vv} ;;
    -k|--key-private) key_private=${vv} ;;
    -h|--host) host=${vv} ;;
    *) printf "Error: Invalid argument $kk\n"; exit 1
  esac
done

mkdir -p ~/.ssh
echo "$key_private" | tr -d '\r' > ~/.ssh/private.pem
key_private_file=(~/.ssh/private.pem)
[[ -f /.dockerenv ]] && echo -e "Host $host\n\tHostName $domain\n\tPort $port\n\tUser $user\n\tIdentityFile $key_private_file\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
chmod -R 700 ~/.ssh
