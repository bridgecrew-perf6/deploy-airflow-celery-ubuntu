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

# SETUP PYTHON VIRTUAL ENV
VIRT_ENV_FOLDER=$HOME/.env/ 

# create virtual env
python3 -m venv $VIRT_ENV_FOLDER/airflow_env

msg "Environment: airflow_env activated"
source $VIRT_ENV_FOLDER/airflow_env/bin/activate
python_version=$(python --version)
msg "Python Version: ${python_version}"

# In case conda install needed:
# ```bash
# cd /tmp
# mkdir -p miniconda && cd miniconda
# curl -OJ https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# chmod u+x Miniconda3-latest-Linux-x86_64.sh
# echo "You can manually install miniconda by exec ./Miniconda3-latest-Linux-x86_64.sh"
# ```

msg "Basic pip packages"
pip install wheel


msg "Update setuptools in order that it works with celery 5.2.x"
pip install setuptools==59.6.0

msg "Modules needed by airflow"
pip install psycopg2-binary 

msg "Installing apache airflow"
AIRFLOW_VERSION=2.2.5
PYTHON_VERSION=3.8
CONSTRAIN_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
msg "Constrains: ${CONSTRAIN_URL}"
# pip install "apache-airflow[celery,redis]==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}" # not working check
pip install "apache-airflow[celery,redis]==2.2.5" --constraint https://raw.githubusercontent.com/apache/airflow/constraints-2.2.5/constraints-3.8.txt # hardwired

