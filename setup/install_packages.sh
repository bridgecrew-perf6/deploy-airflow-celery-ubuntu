#!/bin/bash

nc=$(echo -en '\033[0m')
red=$(echo -en '\033[00;31m')
green=$(echo -en '\033[00;32m')
yellow=$(echo -en '\033[00;33m')

function msg {
  echo -e "${green}$(date): ${yellow}$1${nc}"
}

function fail {
  echo -e "${green}$(date): ${red}ERROR: $? ${nc}"  
  msg "Error : $?"
  exit 1
}

function mcd {
  mkdir -p "$1" || fail
  cd "$1" || fail
}

msg "------------- PACKAGES INSTALLATION --------------------------"

msg "Ubuntu update & upgrade"
sudo apt update -y || fail
sudo apt upgrade -y || fail

msg "Build"
sudo apt-get install gcc -y || fail

msg "Python"
sudo apt install -y python3-pip -y || fail
sudo apt install python3-dev -y || fail
sudo apt install -y python3-venv -y || fail
sudo apt install python3-lib2to3 -y || fail
sudo apt install python3-wheel -y || fail


# basic
msg "Basic packages"
sudo apt install git -y || fail
sudo apt install curl -y || fail
sudo apt install rsync -y || fail
sudo apt install build-essential -y || fail
sudo apt install apt-transport-https  || fail # Make sure the packages we will get from a repository are from the genuine source and signed by the Public key
sudo apt install net-tools || fail



msg "Libs"
sudo apt install libssl-dev -y || fail # implementation of the SSL and TLS cryptographic protocols
sudo apt install libffi-dev -y || fail # A Portable Foreign Function Interface Library (used by Cpython)
# sudo apt install netcat -y # computer networking utility
# sudo apt install libkrb5-dev -y # kerberos
# sudo apt install libsasl2-dev -y # cyrus SASL (authentication abstraction library)
# sudo apt install libpq-dev -y # C application programmer's interface to PostgreSQL
# sudo apt install default-libmysqlclient-dev -y
# sudo apt install apt-utils -y # less used command line utilities related to APT
# sudo apt install locales -y # translations

# msg "Postgres"
# sudo apt install postgresql postgresql-contrib -y || fail

# msg "Redis"
# sudo apt install redis-server -y || fail

# msg "Nginx"
# sudo apt install nginx -y || fail

# not installed
# sudo apt install psycopg2-binary -y # installed via pip
