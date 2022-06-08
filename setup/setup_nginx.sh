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

source $HOME/deploy-airflow-celery-ubuntu/secrets.sh

# SCRIPT FROM DO-COMMUNITY:
# https://raw.githubusercontent.com/do-community/automated-setups/master/Ubuntu-18.04/initial_server_setup.sh
# set -euo pipefail

sudo ufw allow 'Nginx HTTP'
ufw_status=$(sudo ufw status)
msg "ufw status: ${ufw_status}"


# nginx config file 

msg "creating nginx config file"

# sudo tee /etc/nginx/sites-available/airflow <<EOF
# ### sudo vi /etc/nginx/sites-available/airflow ### 
# server {
#     listen 80;
#     server_name _;

# location / {
#         proxy_pass http://localhost:8080;
#         proxy_set_header Host \$host;
#         proxy_redirect off;
#         proxy_http_version 1.1;
#         proxy_set_header Upgrade \$http_upgrade;
#         proxy_set_header Connection "upgrade";
#     }
# }
# EOF

sudo tee /etc/nginx/sites-available/airflow <<EOF
server {
    listen 80;
    server_name ${SERVER_IP};

    location / {
        proxy_pass http://0.0.0.0:8080; 
    }
}
EOF


airflow_config=$(cat /etc/nginx/sites-available/airflow)
msg "Airflow created config"
echo -e "\n${green}$airflow_config${nc}"

msg "remove default config"
sudo rm /etc/nginx/sites-enabled/default

msg "create symbolic link sites-available >> sites-enabled "
sudo ln -s /etc/nginx/sites-available/airflow /etc/nginx/sites-enabled/airflow

msg "check nginx config is correct"
sudo nginx -t

msg "reload the config, no need for restart"
sudo systemctl reload nginx
sudo systemctl restart nginx

msg "nginx status"
systemctl status nginx


