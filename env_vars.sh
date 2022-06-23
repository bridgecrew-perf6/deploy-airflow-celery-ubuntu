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



#------------------------------------------
#                 [core]
#------------------------------------------
echo -e "\n${green}[core]${nc}"

# env vars
AIRFLOW__CORE__DAGS_FOLDER="${DAGS_FOLDER}"
AIRFLOW__CORE__PARALLELISM=16
AIRFLOW__CORE__WORKER_CONCURRENCY=8
AIRFLOW__CORE__MAX_ACTIVE_TASKS_PER_DAG=4
AIRFLOW__CORE__EXECUTOR=CeleryExecutor
AIRFLOW__CORE__SQL_ALCHEMY_CONN="postgresql+psycopg2://${SQL_CONN_STRING}"
AIRFLOW__CORE__SQL_ALCHEMY_SCHEMA=$POSTGRES_SCHEMA
AIRFLOW__CORE__PLUGINS_FOLDER="${AIRFLOW_HOME}/plugins"

# export vars
export AIRFLOW__CORE__DAGS_FOLDER
export AIRFLOW__CORE__PARALLELISM
export AIRFLOW__CORE__WORKER_CONCURRENCY
export AIRFLOW__CORE__MAX_ACTIVE_TASKS_PER_DAG
export AIRFLOW__CORE__EXECUTOR
export AIRFLOW__CORE__SQL_ALCHEMY_CONN
export AIRFLOW__CORE__SQL_ALCHEMY_SCHEMA
export AIRFLOW__CORE__PLUGINS_FOLDER

# print vars
msg "dags_folder:" $AIRFLOW__CORE__DAGS_FOLDER
msg "paralelism:" "${AIRFLOW__CORE__PARALLELISM}"
msg "worker_concurrency:" "${AIRFLOW__CORE__WORKER_CONCURRENCY}"
msg "max_active_tasks_per_dag:" "${AIRFLOW__CORE__MAX_ACTIVE_TASKS_PER_DAG}"
msg "executor:" $AIRFLOW__CORE__EXECUTOR
msg "sql_alchemy_conn:" $AIRFLOW__CORE__SQL_ALCHEMY_CONN
msg "sql_alchemy_schema" $AIRFLOW__CORE__SQL_ALCHEMY_SCHEMA
msg "plugins_folder" $AIRFLOW__CORE__SQL_ALCHEMY_SCHEMA


#------------------------------------------
#                 [logging]
#------------------------------------------
echo -e "\n${green}[logging]${nc}"


# env vars
AIRFLOW__LOGGING__BASE_LOG_FOLDER="${AIRFLOW_HOME}/logs"
AIRFLOW__LOGGING__DAG_PROCESSOR_MANAGER_LOG_LOCATION="${AIRFLOW_HOME}/logs/dag_processor_manager/dag_processor_manager.log"

# export vars
export AIRFLOW__LOGGING__BASE_LOG_FOLDER
export AIRFLOW__LOGGING__DAG_PROCESSOR_MANAGER_LOG_LOCATION

# print vars
msg "base_log_folder:" $AIRFLOW__LOGGING__BASE_LOG_FOLDER
msg "dag_processor_manager_log_location:" $AIRFLOW__LOGGING__DAG_PROCESSOR_MANAGER_LOG_LOCATION


#------------------------------------------
#                 # [scheduler]
#------------------------------------------
echo -e "\n${green}[scheduler]${nc}"
AIRFLOW__SCHEDULER__CHILD_PROCESS_LOG_DIRECTORY="${AIRFLOW_HOME}/logs/scheduler"
export AIRFLOW__SCHEDULER__CHILD_PROCESS_LOG_DIRECTORY
msg "child_process_log_directory:" $AIRFLOW__SCHEDULER__CHILD_PROCESS_LOG_DIRECTORY

#------------------------------------------
#                 # [celery]
#------------------------------------------
echo -e "\n${green}[celery]${nc}"

# env vars
AIRFLOW__CELERY__BROKER_URL=$REDIS_CONN_STRING
AIRFLOW__CELERY__RESULT_BACKEND="db+postgresql://${SQL_CONN_STRING}"

# export vars
export AIRFLOW__CELERY__BROKER_URL
export AIRFLOW__CELERY__RESULT_BACKEND

# print vars
msg "broker_url:" $AIRFLOW__CELERY__BROKER_URL
msg "result_backend:" $AIRFLOW__CELERY__RESULT_BACKEND

echo -e "${green}--------------------------------------\n${nc}"