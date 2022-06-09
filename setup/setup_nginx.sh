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


##-------------  START OF THE SCRIPT  --------------##

source $HOME/deploy-airflow-celery-ubuntu/secrets.sh

# SCRIPT FROM DO-COMMUNITY:
# https://raw.githubusercontent.com/do-community/automated-setups/master/Ubuntu-18.04/initial_server_setup.sh
# set -euo pipefail

sudo ufw allow 'Nginx HTTP'
ufw_status=$(sudo ufw status)
msg "ufw status: ${ufw_status}"


sudo tee /etc/nginx/sites-available/airflow <<EOF
server {
    listen 8080;
    server_name ${SERVER_IP};
}
EOF

msg "Airflow: create symbolic link sites-available >> sites-enabled "
sudo ln -s /etc/nginx/sites-available/airflow /etc/nginx/sites-enabled/airflow

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

# sudo tee /etc/nginx/sites-available/airflow <<EOF
# server {
#     listen 80;
#     server_name ${SERVER_IP};

#     location / {
#         proxy_pass http://0.0.0.0:8080; 
#     }
# }
# EOF

# sudo tee /etc/nginx/sites-available/airflow <<EOF
# server {
#     listen 80;
#     server_name ${SERVER_IP};
# }
# EOF

# msg "Airflow: nginx config"
# sudo tee /etc/nginx/sites-available/airflow <<EOF
# server {
#     listen 80;
#     server_name ${SERVER_IP};

#     location / {
#         proxy_pass http://localhost:8080; 
#         proxy_set_header Host \$host;
#         proxy_redirect off;
#         proxy_http_version 1.1;
#         proxy_set_header Upgrade \$http_upgrade;
#         proxy_set_header Connection "upgrade";
#     }
# }
# EOF

# airflow_config=$(cat /etc/nginx/sites-available/airflow)
# echo -e "\n${green}$airflow_config${nc}"

# msg "Airflow: create symbolic link sites-available >> sites-enabled "
# sudo ln -s /etc/nginx/sites-available/airflow /etc/nginx/sites-enabled/airflow


# msg "Flower: nginx config"
# sudo tee /etc/nginx/sites-available/flower <<EOF
# server {
#     listen 5555;
#     server_name ${SERVER_IP}:5555;

#     location / {
#         proxy_pass http://localhost:5555; 
#         proxy_set_header Host \$host;
#         proxy_redirect off;
#         proxy_http_version 1.1;
#         proxy_set_header Upgrade \$http_upgrade;
#         proxy_set_header Connection "upgrade";
#     }
# }
# EOF

sudo tee /etc/nginx/sites-available/flower <<EOF
server {
    listen 5555;
    server_name ${SERVER_IP};
}
EOF

airflow_config=$(cat /etc/nginx/sites-available/flower)
echo -e "\n${green}$airflow_config${nc}"

msg "Flower: create symbolic link sites-available >> sites-enabled "
sudo ln -s /etc/nginx/sites-available/flower /etc/nginx/sites-enabled/flower


msg "remove default config"
sudo rm /etc/nginx/sites-enabled/default


msg "check nginx config is correct"
sudo nginx -t

msg "reload the config, no need for restart"
sudo systemctl reload nginx
sudo systemctl restart nginx

msg "nginx status"
systemctl status nginx


