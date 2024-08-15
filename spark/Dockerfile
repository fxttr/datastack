# syntax=docker/dockerfile:1
FROM eclipse-temurin:11-jre-jammy

ARG spark_uid=185

RUN groupadd --system --gid=${spark_uid} spark && \
  useradd --system --uid=${spark_uid} --gid=spark spark

RUN apt update && apt upgrade -y && \
  apt install -y --no-install-recommends \
  python3 \
  python3-pip \
  sudo \
  curl \
  unzip \
  make \
  tini \
  wget \
  build-essential \
  software-properties-common \
  libpq-dev \
  gcc \
  g++ \
  libsasl2-dev \
  libsasl2-2\ 
  libsasl2-modules-gssapi-mit\
  unixodbc-dev \
  ssh \
  rsync \
  vim \
  postgresql-client; \
  mkdir -p /opt/spark; \
  mkdir /opt/spark/python; \
  mkdir -p /opt/spark/work-dir; \
  chmod g+w /opt/spark/work-dir; \
  touch /opt/spark/RELEASE; \
  chown -R spark:spark /opt/spark; \
  echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su; \
  rm -rf /var/lib/apt/lists/*

ENV METASTORE_HADOOP_VERSION=3.2.0
ENV METASTORE_VERSION=3.0.0
ENV SPARK_VERSION=3.5.2
ENV SPARK_MAJOR_VERSION=3.5
ENV HADOOP_VERSION=3
ENV SCALA_VERSION=2.12
ENV ICEBERG_VERSION=1.6.0
ENV PYTHONHASHSEED=1
ENV SPARK_HOME=/opt/spark
ENV SPARK_MASTER_PORT=7077
ENV SPARK_MASTER_WEBUI_PORT=8111
ENV SPARK_LOG_DIR=/opt/spark/logs
ENV SPARK_MASTER_LOG=/opt/spark/logs/spark-master.out
ENV SPARK_WORKER_LOG=/opt/spark/logs/spark-worker.out
ENV SPARK_WORKER_PORT=7000
ENV SPARK_MASTER="spark://spark:7077"
ENV SPARK_WORKLOAD="master"
ENV DAGSTER_HOME=/opt/dagster
ENV KYUUBI_HOME=/opt/kyuubi
ENV BIN_DIR=/usr/bin
ENV DAGSTER_DIR=/var/lib/prometheus_stack/dagster
ENV DBT_DIR=/var/lib/prometheus_stack/dbt
ENV NOTEBOOKS_DIR=/var/lib/prometheus_stack/notebooks
ENV DATA_STAGE_DIR=/var/lib/prometheus_stack/stage
ENV HTML_DIR=/var/lib/prometheus_stack/html
ENV PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9.7-src.zip:$PYTHONPATH

# Add iceberg spark runtime jar to IJava classpath
ENV IJAVA_CLASSPATH=/opt/spark/jars/*
ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}"
ENV INSTALL_DIR=/tmp/install


RUN mkdir -p ${MINIO_HOME}/bin ${DAGSTER_HOME}  ${KYUUBI_HOME} \ 
  ${DAGSTER_DIR} ${DBT_DIR} ${DATA_STAGE_DIR} ${NOTEBOOKS_DIR} ${INSTALL_DIR} ${HTML_DIR} \
  /root/.ipython/profile_default/startup

RUN mkdir -p $SPARK_LOG_DIR && \
  touch $SPARK_MASTER_LOG && \
  touch $SPARK_WORKER_LOG && \
  ln -sf /dev/stdout $SPARK_MASTER_LOG && \
  ln -sf /dev/stdout $SPARK_WORKER_LOG

WORKDIR ${INSTALL_DIR}

# Install python deps
COPY conf/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt \
  && rm requirements.txt

# Download and install IJava jupyter kernel
RUN curl https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip -Lo ijava-1.3.0.zip \
  && unzip ijava-1.3.0.zip \
  && python3 install.py --sys-prefix \
  && rm -rf ijava-1.3.0.zip	install.py java \
  # Download spark distribution and install it
  && curl "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" -o "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
  && tar xvzf "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" --directory /opt/spark --strip-components 1 \
  && rm "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
  # Download iceberg spark runtime
  && curl https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}/${ICEBERG_VERSION}/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}.jar -Lo ${SPARK_HOME}/jars/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}.jar -Lo iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}.jar  \
  # Download Java AWS SDK
  && curl https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/${ICEBERG_VERSION}/iceberg-aws-bundle-${ICEBERG_VERSION}.jar  -Lo ${SPARK_HOME}/jars/iceberg-aws-bundle-${ICEBERG_VERSION}.jar \
  # Download URL connection client required for S3FileIO
  && curl https://repo1.maven.org/maven2/software/amazon/awssdk/url-connection-client/2.9.9/url-connection-client-2.9.9.jar -Lo ${SPARK_HOME}/jars/url-connection-client-2.9.9.jar \
  # Install AWS CLI
  && curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && sudo ./aws/install \
  && rm awscliv2.zip \
  && rm -rf aws/ \
  # Download and install Kyuubi JDBC
  && curl https://archive.apache.org/dist/incubator/kyuubi/kyuubi-1.6.1-incubating/apache-kyuubi-1.6.1-incubating-bin.tgz -Lo kyuubi.tgz \ 
  && tar xvzf kyuubi.tgz --directory ${KYUUBI_HOME} --strip-components 1 \
  && rm kyuubi.tgz \
  # Download SAP HANA driver
  && curl https://repo1.maven.org/maven2/com/sap/cloud/db/jdbc/ngdbc/2.21.11/ngdbc-2.21.11.jar -Lo ${SPARK_HOME}/jars/ngdbc.jar 

WORKDIR ${SPARK_HOME}

COPY conf/spark-defaults.conf ${SPARK_HOME}/conf
COPY conf/dagster.yaml ${DAGSTER_HOME}
COPY scripts/entrypoint.sh ${BIN_DIR}
COPY conf/ipython/startup/00-prettytables.py /root/.ipython/profile_default/startup
COPY conf/ipython/startup/README /root/.ipython/profile_default/startup
COPY conf/notebook ${BIN_DIR}/notebook
COPY conf/notebook ${BIN_DIR}/pyspark-notebook
COPY conf/dagster.yaml ${DAGSTER_HOME}/dagster.yaml
COPY conf/.pyiceberg.yaml /root/.pyiceberg.yaml

RUN chmod u+x ${SPARK_HOME}/* \
  && chmod u+x ${SPARK_HOME}/bin/* \
  && chmod u+x ${BIN_DIR}/notebook \
  && chmod u+x ${BIN_DIR}/pyspark-notebook

EXPOSE 3070
EXPOSE 6066
EXPOSE 7000
EXPOSE 7077
EXPOSE 8061
EXPOSE 8062
EXPOSE 8111
EXPOSE 8888
EXPOSE 10000
EXPOSE 10009
EXPOSE 18080

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["notebook"]