#!/usr/bin/env bash

sudo certbot certonly --standalone --email main@noname.team --agree-tos --no-eff-email -d $1
