#!/bin/bash


# HELPERS
# colors
nc=$(echo -en '\033[0m')
red=$(echo -en '\033[00;31m')
green=$(echo -en '\033[00;32m')
yellow=$(echo -en '\033[00;33m')
function msg {
  echo -e "${green}$(date): ${yellow}$1${nc}"
}

# Activate virtual env
source ~/.env/airflow_env/bin/activate
source $HOME/deploy-airflow-celery-ubuntu/secrets.sh
source $HOME/deploy-airflow-celery-ubuntu/env_vars.sh



# Check airflow
airflow_version=$(airflow version)
msg "Airflow version: ${airflow_version}"


msg "AIRFLOW_HOME: ${AIRFLOW_HOME}"

msg "Airflow db init"
# airflow db reset
airflow db init


msg "Airflow user creation"
airflow users create --role $AIRFLOW_ROLE --username $AIRFLOW_USERNAME --password $AIRFLOW_PASSWORD --firstname $AIRFLOW_FIRSTNAME --lastname $AIRFLOW_LASTNAME --email $AIRFLOW_EMAIL


