#!/bin/bash


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
# get current script path
function curr_script_path {
  echo -e "$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )"
}


# Load secrets & env vars
PROJECT_ROOT=$(curr_script_path)
source $PROJECT_ROOT/secrets.sh
source $PROJECT_ROOT/env_vars.sh

# Activate python virtual environment
source $HOME/.env/airflow_env/bin/activate


# Check airflow
airflow_version=$(airflow version)
msg "Airflow version: ${airflow_version}"


msg "AIRFLOW_HOME: ${AIRFLOW_HOME}"

msg "Airflow db init"
# airflow db reset
airflow db init


msg "Airflow user creation"
airflow users create --role $AIRFLOW_ROLE --username $AIRFLOW_USERNAME --password $AIRFLOW_PASSWORD --firstname $AIRFLOW_FIRSTNAME --lastname $AIRFLOW_LASTNAME --email $AIRFLOW_EMAIL


