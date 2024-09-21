FROM python:3.12-slim

RUN pip install \
    dagster \
    dagster-graphql \
    dagster-webserver \
    dagster-postgres \
    dagster-docker \
    dagster-dbt \
    dagster-pyspark \
    dagster-spark 

RUN apt update && apt upgrade -y && apt install default-jdk -y

ENV PYSPARK_SUBMIT_ARGS="--master spark://spark:7077"
ENV JAVA_HOME=/usr/lib/jvm/default-java/
ENV DAGSTER_DIR=/var/lib/fxttr/dagster
ENV DAGSTER_HOME=/opt/dagster/dagster_home/

RUN mkdir -p ${DAGSTER_HOME} ${DAGSTER_DIR}

COPY conf/dagster.yaml ${DAGSTER_HOME}/dagster.yaml

WORKDIR $DAGSTER_HOME