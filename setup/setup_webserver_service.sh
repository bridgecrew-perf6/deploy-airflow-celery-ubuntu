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



# AIRFLOW WEBSERVER SERVICE
msg "Creating airflow webserver service symbolic link"
sudo ln -s /home/airflow/deploy-airflow-celery-ubuntu/services/airflow_webserver.service /etc/systemd/system/airflow_webserver.service

msg "Restart webserver service"
sudo systemctl daemon-reload
sudo systemctl restart airflow_webserver.service

msg "Status webserver service"
systemctl status airflow_webserver.service