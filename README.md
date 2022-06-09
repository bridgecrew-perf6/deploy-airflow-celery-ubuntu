# Deploying Airflow in Digital Ocean

Deploy Airflow for distributed computing using several VPS workers linked on a VPC on Digitalocean
with celery, redis.

Disclaimer: This demo is only for educational purposes, this setup should not be deployed by any means in production


## As user "root"

1. Connect to server with ssh root@host (put in host your machine ip or host url) and clone the repo  `git clone https://github.com/felrobotics/deploy-airflow-celery-ubuntu.git`
2. Create user "airflow" by running the script setup/create_users.sh
3. Logout root (not recommened to work as root user)

## Setup with user "airflow"

1. Login ssh airflow@host and clone the repo `git clone https://github.com/felrobotics/deploy-airflow-celery-ubuntu.git`
2. Install ubuntu packages with setup/install_packages.sh
   
## Upload Secrets   

1. copy secrets_dummy.sh to secrets.sh and fill out the secrets or if you have your file in your local machine just upload it from
your local machine running: `rsync -e ssh secrets.sh  airflow@host:deploy-airflow-celery-ubuntu/`

## Setup Python & Airflow

1. Setup python and virtual envs setup/running setup_python.sh
2. Setup airflow database schema with setup/setup_schemas.sh
3. Setup airflow db and users by running setup/setup_airflow

## Setup Nginx for airflow webserver and flower

Disclaimer: This is only a demo, nginx reverse proxy will be working with minimum security
- run script setup/nginx.sh


## Setup Systemd Services for activating aiflow at restart and failure

If you are in the master machine that will run the scheduler and webserver:

- run script setup/setup_services.sh

In a worker machine only celery worker service needed, just run

-  setup/setup_worker_services.sh

## For stoping, restarting, status and activating of systemd services 

There are 4 services (airflow_<service_name>.service), namely:

    - airflow_scheduler.service
    - airflow_webserver.service
    - airflow_flower.service
    - airflow_worker.service

Start, restart, and stop: 

- sudo systemctl start airflow_<service_name>.service  
- sudo systemctl restart airflow_<service_name>.service
- sudo systemctl stop airflow_<service_name>.service

Status :
- sudo systemctl status airflow_<service_name>.service




