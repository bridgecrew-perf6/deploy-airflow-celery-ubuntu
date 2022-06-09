#!/bin/bash

# set -euo pipefail

##-------------  HELPERS   --------------##
# colors
nc=$(echo -en '\033[0m')
red=$(echo -en '\033[00;31m')
green=$(echo -en '\033[00;32m')
yellow=$(echo -en '\033[00;33m')

# pretty printing
function msg {
  # echo -e "${green}$(date): ${yellow}$1${nc}"
  echo -e "${green}[$(date +"%Y/%m/%d - %H:%M:%S")] ${yellow}$1${nc}" # better date format
}


##-------------  START OF THE SCRIPT  --------------##

# WORKER
msg "Creating airflow celery worker service symbolic link"
sudo ln -s /home/airflow/deploy-airflow-celery-ubuntu/services/airflow_worker.service /etc/systemd/system/airflow_worker.service

msg "Restart worker service"
sudo systemctl daemon-reload
sudo systemctl restart airflow_worker.service

msg "Status worker service"
systemctl status airflow_worker.service

