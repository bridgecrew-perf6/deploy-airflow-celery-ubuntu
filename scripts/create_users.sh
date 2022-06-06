#!/bin/bash

nc=$(echo -en '\033[0m')
red=$(echo -en '\033[00;31m')
green=$(echo -en '\033[00;32m')
yellow=$(echo -en '\033[00;33m')

function msg {
  echo -e "${green}$(date): ${yellow}$1${nc}"
}

source ../secrets.sh
msg "${$UBUNTU_USER}"
adduser $UBUNTU_USER
usermod -aG sudo $UBUNTU_USER