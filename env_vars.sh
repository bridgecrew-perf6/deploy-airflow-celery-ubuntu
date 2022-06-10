#!/bin/bash

##-------------  HELPERS   --------------##
# colors
nc=$(echo -en '\033[0m')
red=$(echo -en '\033[00;31m')
green=$(echo -en '\033[00;32m')
yellow=$(echo -en '\033[00;33m')

# pretty printing
function msg {
  echo -e "${yellow}$1 ${nc}$2"
}

# get current script path
function curr_script_path {
  echo -e "$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )"
}


# LOAD SECRETS 
PROJECT_ROOT=$(curr_script_path)
source $PROJECT_ROOT/secrets.sh


echo -e "\n\n${green}--------------------------------------"
echo -e "          AIRFLOW  env vars"
echo -e "--------------------------------------${nc}"

# AIRFLOW HOME
AIRFLOW_HOME="${AIRFLOW_HOME_FOLDER}"
export AIRFLOW_HOME
msg "airflow_home:" $AIRFLOW_HOME


#[core]
echo -e "\n${green}[core]${nc}"

# DAGS FOLDER
AIRFLOW__CORE__DAGS_FOLDER="${DAGS_FOLDER}"
export AIRFLOW__CORE__DAGS_FOLDER
msg "dags_folder:" $AIRFLOW__CORE__DAGS_FOLDER

# PARALLELISM & WORKER CONCURRENCY & MAX ACTIVE TASKS
AIRFLOW__CORE__PARALLELISM=16
AIRFLOW__CORE__WORKER_CONCURRENCY=8
AIRFLOW__CORE__MAX_ACTIVE_TASKS_PER_DAG=4

export AIRFLOW__CORE__PARALLELISM
export AIRFLOW__CORE__WORKER_CONCURRENCY
export AIRFLOW__CORE__MAX_ACTIVE_TASKS_PER_DAG

msg "paralelism:" "${AIRFLOW__CORE__PARALLELISM}"
msg "worker_concurrency:" "${AIRFLOW__CORE__WORKER_CONCURRENCY}"
msg "max_active_tasks_per_dag:" "${AIRFLOW__CORE__MAX_ACTIVE_TASKS_PER_DAG}"

# EXECUTOR
# AIRFLOW__CORE__EXECUTOR=LocalExecutor
AIRFLOW__CORE__EXECUTOR=CeleryExecutor
export AIRFLOW__CORE__EXECUTOR
msg "executor:" $AIRFLOW__CORE__EXECUTOR


AIRFLOW__CORE__SQL_ALCHEMY_CONN="postgresql+psycopg2://${POSTGRES_USERNAME}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}${POSTGRES_EXTRAS}"
export AIRFLOW__CORE__SQL_ALCHEMY_CONN
msg "sql_alchemy_conn:" $AIRFLOW__CORE__SQL_ALCHEMY_CONN


# sql_alchemy_schema = omni_mlops_local_luisposada_e8d0fcfe0f4d_aif
AIRFLOW__CORE__SQL_ALCHEMY_SCHEMA=$POSTGRES_SCHEMA
export AIRFLOW__CORE__SQL_ALCHEMY_SCHEMA
msg "sql_alchemy_schema" $AIRFLOW__CORE__SQL_ALCHEMY_SCHEMA


# plugins_folder = /home/luisposada/airflow/plugins
AIRFLOW__CORE__PLUGINS_FOLDER="${AIRFLOW_HOME}/plugins"
export AIRFLOW__CORE__PLUGINS_FOLDER
msg "plugins_folder" $AIRFLOW__CORE__SQL_ALCHEMY_SCHEMA

#---------------------------------------
# [logging]
echo -e "\n${green}[logging]${nc}"


# base_log_folder = /home/luisposada/airflow/logs
AIRFLOW__LOGGING__BASE_LOG_FOLDER="${AIRFLOW_HOME}/logs"
export AIRFLOW__LOGGING__BASE_LOG_FOLDER
msg "base_log_folder:" $AIRFLOW__LOGGING__BASE_LOG_FOLDER


# dag_processor_manager_log_location = /home/luisposada/airflow/logs/dag_processor_manager/dag_processor_manager.log
AIRFLOW__LOGGING__DAG_PROCESSOR_MANAGER_LOG_LOCATION="${AIRFLOW_HOME}/logs/dag_processor_manager/dag_processor_manager.log"
export AIRFLOW__LOGGING__DAG_PROCESSOR_MANAGER_LOG_LOCATION
msg "dag_processor_manager_log_location:" $AIRFLOW__LOGGING__DAG_PROCESSOR_MANAGER_LOG_LOCATION


# [scheduler]
echo -e "\n${green}[scheduler]${nc}"
# child_process_log_directory = /home/luisposada/airflow/logs/scheduler
AIRFLOW__SCHEDULER__CHILD_PROCESS_LOG_DIRECTORY="${AIRFLOW_HOME}/logs/scheduler"
export AIRFLOW__SCHEDULER__CHILD_PROCESS_LOG_DIRECTORY
msg "child_process_log_directory:" $AIRFLOW__SCHEDULER__CHILD_PROCESS_LOG_DIRECTORY

#---------------------------------------
# [celery]
echo -e "\n${green}[celery]${nc}"

# DEFAULTS
# broker_url = redis://redis:6379/0
# result_backend = db+postgresql://postgres:airflow@postgres/airflow
# NEW VALUES
# AIRFLOW__CELERY__BROKER_URL="redis://${REDIS_USERNAME}:${REDIS_PASSWORD}@${REDIS_HOST}:${REDIS_PORT}/${REDIS_DB_NUMBER}"
AIRFLOW__CELERY__BROKER_URL=$REDIS_CONN_STRING

AIRFLOW__CELERY__RESULT_BACKEND="db+postgresql://${POSTGRES_USERNAME}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}${POSTGRES_EXTRAS}"
export AIRFLOW__CELERY__BROKER_URL
export AIRFLOW__CELERY__RESULT_BACKEND
msg "broker_url:" $AIRFLOW__CELERY__BROKER_URL
msg "result_backend:" $AIRFLOW__CELERY__RESULT_BACKEND

echo -e "${green}--------------------------------------\n${nc}"