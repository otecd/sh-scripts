#!/usr/bin/env bash

sudo adduser -q --disabled-password --gecos "$USER_NAME" $USER_LOGIN
sudo usermod -aG sudo,docker $USER_LOGIN

sudo -i -u $USER_LOGIN bash << EOF
cat >> /home/$USER_LOGIN/.bashrc <<- EOM
# git aliases
alias gs='git status'
alias gd='git diff'
alias gc='git commit -m'
alias ga='git add -p'
alias gpu='git push -u'
alias gpf='git push -f'
alias gl='git log --oneline -n'
alias gclo='git clone --recurse-submodules'
alias gtd='git tag -d'
alias gtdr='git push origin -d'
# docker aliases
alias dc='/usr/local/bin/docker-compose'
alias d='/usr/bin/docker'

export EDITOR=nano
EOM
ssh-keygen -o -t rsa -b4096 -f /home/$USER_LOGIN/.ssh/id_rsa -q -N ""
cat >> /home/$USER_LOGIN/.ssh/authorized_keys <<- EOM

$SSH_KEY

EOM
git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"
git config --global diff.submodule log
git config --global status.submodulesummary 1
git config --global submodule.recurse true
git config --global push.recurseSubmodules check
EOF
