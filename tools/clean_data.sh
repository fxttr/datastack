#!/bin/bash

export BIN_DIR="`dirname \"$0\"`"
export PROMETHEUS_STACK_HOME="$( cd "${BIN_DIR}/.." && pwd )"

cd ${PROMETHEUS_STACK_HOME}/data/mariadb && rm -rf * .* 
cd ${PROMETHEUS_STACK_HOME}/data/minio && rm -rf * .* 
cd ${PROMETHEUS_STACK_HOME}/data/postgres && rm -rf * .* 
# cd ${PROMETHEUS_STACK_HOME}/data/spark && rm -rf * .* 
cd ${PROMETHEUS_STACK_HOME}/data/elasticsearch && rm -rf * .* 
