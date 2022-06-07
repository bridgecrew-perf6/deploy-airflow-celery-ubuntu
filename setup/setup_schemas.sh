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


# Setup schema 

# psql -U postgres << EOF

# DROP DATABASE sis_db; -- drop the DB

# CREATE DATABASE sis_db WITH OWNER = postgres ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' CONNECTION LIMIT = -1;

# \c sis_db

# -- Create some schemas on the DB

# CREATE SCHEMA nomencladores AUTHORIZATION postgres;
# CREATE SCHEMA negocio AUTHORIZATION postgres;
# CREATE SCHEMA usuarios_externos AUTHORIZATION postgres;

# EOF
msg "POSTGRES_USERNAME: ${POSTGRES_USERNAME}"
psql "postgresql://${POSTGRES_USERNAME}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}" << EOF
CREATE SCHEMA ${POSTGRES_SCHEMA};
EOF

# psql "postgresql://doadmin:your_password@cluster-do-user-1234567-0.db.ondigitalocean.com:25060/defaultdb?sslmode=require"

# psql postgresql://[$POSTGRES_USER:password]@][host][:port]  psql << EOF
# SELECT COUNT(*) FROM (
#   SELECT datname FROM pg_catalog.pg_database 
#   WHERE lower(datname)=lower($DATABASE)
# )
# EOF

# DROP SCHEMA $POSTGRES_SCHEMA;
# CREATE SCHEMA $POSTGRES_SCHEMA;
# GRANT ALL ON SCHEMA omni_mlops_local_lposada_1dd07ad7c9ea46a99ce927b55df1cfd1_aif TO luis_posada;
# ALTER USER luis_posada SET search_path = omni_mlops_local_lposada_1dd07ad7c9ea46a99ce927b55df1cfd1_aif;



# msg "AIRFLOW_HOME: ${AIRFLOW_HOME}"

