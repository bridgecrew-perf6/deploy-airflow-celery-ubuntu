# Deploying Airflow in Digital Ocean

Deploy Airflow for distributed computing using several VPS workers linked on a VPC on Digitalocean
with celery, redis.

Disclaimer: This demo is only for educational purposes, this setup should not be deployed by any means in production


## As user "root"

1. Connect to server with ssh root@host and clone the git repo 
2. Create user "airflow" by running the script create_users.sh
3. Logout root (not recommened to work as root user)

## Setup with user "airflow"

1. Login ssh airflow@host and clone the git repo
2. Install ubuntu packages with install_packages.sh
   
## Upload Secrets   

1. Logout from server and run in your local machine the command: `rsync -e ssh secrets.sh  airflow@host:deploy-airflow-celery-ubuntu/`