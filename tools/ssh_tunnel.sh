#!/bin/bash

export BIN_DIR="`dirname \"$0\"`"
export PROMETHEUS_STACK_HOME="$( cd "${BIN_DIR}/.." && pwd )"

ssh -i ${PROMETHEUS_STACK_SSH_KEY_PATH} -f -N -v -L 3000:localhost:3000 -L 4000:localhost:4000 -L 10000:localhost:10000 -L 3245:localhost:3245 -L 8060:localhost:8060 -L 3030:localhost:3030 -L 3070:0.0.0.0:3070 -L 5432:localhost:5432 -L 8888:localhost:8888 ${PROMETHEUS_STACK_SSH_USER}@${PROMETHEUS_STACK_SSH_HOST}
