#!/bin/bash

# HELPERS
# colors
nc=$(echo -en '\033[0m')
red=$(echo -en '\033[00;31m')
green=$(echo -en '\033[00;32m')
yellow=$(echo -en '\033[00;33m')

function msg {
  # echo -e "${green}$(date): ${yellow}$1${nc}"
  echo -e "${green}[$(date +"%Y/%m/%d - %H:%M:%S")] ${yellow}$1${nc}"
}

source secrets.sh


# check redis 
msg "Checking redis server connection"
redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASSWORD
