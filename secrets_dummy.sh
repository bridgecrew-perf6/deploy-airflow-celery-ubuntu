#!/bin/bash

##---------------- CREDENTIALS ------------------##

# Fill out your credentials


SERVER_IP=xxx

# POSTGRES
POSTGRES_USERNAME=xxx
POSTGRES_PASSWORD=xxx
POSTGRES_HOST=xxx
POSTGRES_PORT=xxx
POSTGRES_DB=xxx
POSTGRES_SCHEMA=xxx
# POSTGRES_EXTRAS="?options=-csearch_path%3D${POSTGRES_SCHEMA}"
POSTGRES_EXTRAS=""


# REDIS 
REDIS_USERNAME=xxx
REDIS_PASSWORD=xxx
REDIS_HOST=xxx
REDIS_PORT=xxx
REDIS_DB_NUMBER=xxx
REDIS_CONN_STRING="redis://${REDIS_USERNAME}:${REDIS_PASSWORD}@${REDIS_HOST}:${REDIS_PORT}"


# AIRFLOW
AIRFLOW_ROLE=xxx
AIRFLOW_USERNAME=xxx
AIRFLOW_PASSWORD=xxx
AIRFLOW_FIRSTNAME=xxx
AIRFLOW_LASTNAME=xxx
AIRFLOW_EMAIL=xxx