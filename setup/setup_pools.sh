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

# # get current script path
# function curr_script_path {
#   echo -e "$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )"
# }

# PROJECT_ROOT=$(curr_script_path)
source secrets.sh
source env_vars.sh
source $HOME/.env/airflow_env/bin/activate

# POOLS
msg "Creating a pool with parallelism 1 for resource-intensive processes where process cannot run in paralell"
airflow pools import -v  setup/pools.json


