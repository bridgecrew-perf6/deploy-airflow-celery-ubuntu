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
##-------------  HELPERS   --------------##

##-------------  START OF THE SCRIPT  --------------##

# AIRFLOW SCHEDULER
msg "Creating airflow scheduler service symbolic link"
sudo ln -s /home/airflow/deploy-airflow-celery-ubuntu/services/airflow_scheduler.service /etc/systemd/system/airflow_scheduler.service

msg "Restart scheduler service"
sudo systemctl daemon-reload
sudo systemctl restart airflow_scheduler.service

msg "Status scheduler service"
systemctl status airflow_scheduler.service

# AIRFLOW WEBSERVER
msg "Creating airflow webserver service symbolic link"
sudo ln -s /home/airflow/deploy-airflow-celery-ubuntu/services/airflow_webserver.service /etc/systemd/system/airflow_webserver.service

msg "Restart webserver service"
sudo systemctl daemon-reload
sudo systemctl restart airflow_webserver.service

msg "Status webserver service"
systemctl status airflow_webserver.service

# FLOWER 
msg "Creating airflow flower service symbolic link"
sudo ln -s /home/airflow/deploy-airflow-celery-ubuntu/services/airflow_flower.service /etc/systemd/system/airflow_flower.service

msg "Restart flower service"
sudo systemctl daemon-reload
sudo systemctl restart airflow_flower.service

msg "Status flower service"
systemctl status airflow_flower.service

