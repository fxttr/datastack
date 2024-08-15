#!/bin/bash

export DAGSTER_HOME=/opt/dagster
export KYUUBI_HOME=/opt/kyuubi
export DAGSTER_DIR=/var/lib/prometheus_stack/projects

if [ -z "$JAVA_HOME" ]; then
  JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk '{print $3}')
fi

SPARK_CLASSPATH="$SPARK_CLASSPATH:${SPARK_HOME}/jars/*"
for v in "${!SPARK_JAVA_OPT_@}"; do
    SPARK_EXECUTOR_JAVA_OPTS+=( "${!v}" )
done

if [ -n "$SPARK_EXTRA_CLASSPATH" ]; then
  SPARK_CLASSPATH="$SPARK_CLASSPATH:$SPARK_EXTRA_CLASSPATH"
fi

if ! [ -z "${PYSPARK_PYTHON+x}" ]; then
    export PYSPARK_PYTHON
fi
if ! [ -z "${PYSPARK_DRIVER_PYTHON+x}" ]; then
    export PYSPARK_DRIVER_PYTHON
fi

if [ -n "${HADOOP_HOME}"  ] && [ -z "${SPARK_DIST_CLASSPATH}"  ]; then
  export SPARK_DIST_CLASSPATH="$($HADOOP_HOME/bin/hadoop classpath)"
fi

if ! [ -z "${HADOOP_CONF_DIR+x}" ]; then
  SPARK_CLASSPATH="$HADOOP_CONF_DIR:$SPARK_CLASSPATH";
fi

if ! [ -z "${SPARK_CONF_DIR+x}" ]; then
  SPARK_CLASSPATH="$SPARK_CONF_DIR:$SPARK_CLASSPATH";
elif ! [ -z "${SPARK_HOME+x}" ]; then
  SPARK_CLASSPATH="$SPARK_HOME/conf:$SPARK_CLASSPATH";
fi

SPARK_CLASSPATH="$SPARK_CLASSPATH:$PWD"

# spark
mkdir -p /tmp/spark-events
start-master.sh -p 7077 --webui-port 8061
start-worker.sh spark://spark:7077 --webui-port 8062
start-history-server.sh
${KYUUBI_HOME}/bin/kyuubi start

# dagster
cd ${DAGSTER_DIR} && dagster-webserver -h 0.0.0.0 -p 3070 &

if [[ $# -gt 0 ]] ; then
    eval "$1"
fi