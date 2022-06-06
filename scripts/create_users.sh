#!/bin/bash

nc=$(echo -en '\033[0m')
red=$(echo -en '\033[00;31m')
green=$(echo -en '\033[00;32m')
yellow=$(echo -en '\033[00;33m')

function msg {
  echo -e "${green}$(date): ${yellow}$1${nc}"
}

source $HOME/deploy-airflow-celery-ubuntu/secrets.sh
msg "${$UBUNTU_USER}"
adduser $UBUNTU_USER
usermod -aG sudo $UBUNTU_USER

# sync ssh keys from root to newly created users
rsync --archive --chown=$UBUNTU_USER:$UBUNTU_USER ~/.ssh /home/$UBUNTU_USER


# sync secrets from local to server 
# rsync -e ssh secrets.sh user@host:deploy-airflow-celery-ubuntu/
