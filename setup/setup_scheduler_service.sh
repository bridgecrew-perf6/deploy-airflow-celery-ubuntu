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

# AIRFLOW SCHEDULER SERVICE
msg "Creating airflow scheduler service symbolic link"
sudo ln -s /home/airflow/deploy-airflow-celery-ubuntu/services/airflow_scheduler.service /etc/systemd/system/airflow_scheduler.service

msg "Restart scheduler service"
sudo systemctl daemon-reload
sudo systemctl restart airflow_scheduler.service

msg "Status scheduler service"
systemctl status airflow_scheduler.service



