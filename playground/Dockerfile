# syntax=docker/dockerfile:1
FROM eclipse-temurin:11-jre-jammy

RUN apt update && apt upgrade -y && \
  apt install -y --no-install-recommends \
  python3 \
  python3-pip \
  sudo \
  curl \
  unzip \
  make \
  build-essential \
  software-properties-common \
  libpq-dev \
  gcc \
  g++ \
  libsasl2-dev \
  libsasl2-2\ 
  libsasl2-modules-gssapi-mit \
  unixodbc-dev \
  && rm -rf /var/lib/apt/lists/*

ENV SPARK_VERSION=3.5.2
ENV SPARK_MAJOR_VERSION=3.5
ENV HADOOP_VERSION=3
ENV SCALA_VERSION=2.12
ENV ICEBERG_VERSION=1.6.0
ENV PYTHONHASHSEED=1
ENV BIN_DIR=/usr/bin
ENV DBT_DIR=/var/lib/fxttr/dbt
ENV NOTEBOOKS_DIR=/var/lib/fxttr/notebooks
ENV SPARK_HOME=/usr/local/lib/python3.10/dist-packages/pyspark/
ENV IJAVA_CLASSPATH=${SPARK_HOME}/jars/*
ENV PATH="/usr/local/lib/python3.10/dist-packages/pyspark/sbin:/usr/local/lib/python3.10/dist-packages/pyspark/bin:${PATH}"
ENV INSTALL_DIR=/tmp/install

RUN mkdir -p ${DBT_DIR} ${DATA_STAGE_DIR} ${NOTEBOOKS_DIR} ${INSTALL_DIR} ${SPARK_HOME}/conf /root/.ipython/profile_default/startup

WORKDIR ${INSTALL_DIR}

# Install python deps
COPY conf/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && rm requirements.txt

# Download and install IJava jupyter kernel
RUN curl https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip -Lo ijava-1.3.0.zip \
  && unzip ijava-1.3.0.zip \
  && python3 install.py --sys-prefix \
  && rm -rf ijava-1.3.0.zip	install.py java \
  # Download Clickhouse dependencies
  && curl https://repo1.maven.org/maven2/com/clickhouse/spark/clickhouse-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}/0.8.0/clickhouse-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-0.8.0.jar -Lo ${SPARK_HOME}/jars/clickhouse-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-0.8.0.jar \
  && curl https://github.com/ClickHouse/clickhouse-java/releases/download/v0.6.4/clickhouse-jdbc-0.6.4-all.jar -Lo ${SPARK_HOME}/jars/clickhouse-jdbc-0.6.4-all.jar \
  # Download iceberg spark runtime
  && curl https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}/${ICEBERG_VERSION}/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}.jar -Lo ${SPARK_HOME}/jars/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}.jar  \
  # Download Nessie extension
  && curl https://repo1.maven.org/maven2/org/projectnessie/nessie-integrations/nessie-spark-extensions-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}/0.95.0/nessie-spark-extensions-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-0.95.0.jar -Lo ${SPARK_HOME}/jars/nessie-spark-extensions-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-0.95.0.jar \
  # Download AWS dependencies
  && curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar -Lo ${SPARK_HOME}/jars/hadoop-aws-3.3.4.jar \
  && curl https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/${ICEBERG_VERSION}/iceberg-aws-bundle-${ICEBERG_VERSION}.jar  -Lo ${SPARK_HOME}/jars/iceberg-aws-bundle-${ICEBERG_VERSION}.jar \
  && curl https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar -Lo ${SPARK_HOME}/jars/aws-java-sdk-bundle-1.12.262.jar \
  && curl https://repo1.maven.org/maven2/software/amazon/awssdk/url-connection-client/2.27.7/url-connection-client-2.27.7.jar -Lo ${SPARK_HOME}/jars/url-connection-client-2.27.7.jar \
  && curl https://repo1.maven.org/maven2/software/amazon/awssdk/s3-transfer-manager/2.27.7/s3-transfer-manager-2.27.7.jar -Lo ${SPARK_HOME}/jars/s3-transfer-manager-2.27.7.jar \
  # Install AWS CLI
  && curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && sudo ./aws/install \
  && rm awscliv2.zip \
  && rm -rf aws/ \
  # Download SAP HANA driver
  && curl https://repo1.maven.org/maven2/com/sap/cloud/db/jdbc/ngdbc/2.21.11/ngdbc-2.21.11.jar -Lo ${SPARK_HOME}/jars/ngdbc.jar \
  # Download MSSQL jdbc
  && curl https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/12.8.1.jre11/mssql-jdbc-12.8.1.jre11.jar -Lo ${SPARK_HOME}/jars/mssql-jdbc-12.8.1.jre11.jar\
  # Download MySQL jdbc
  && curl https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.0.0/mysql-connector-j-9.0.0.jar -Lo ${SPARK_HOME}/jars/mysql-connector-j-9.0.0.jar

WORKDIR ${NOTEBOOKS_DIR}

COPY conf/ipython/startup/00-prettytables.py /root/.ipython/profile_default/startup
COPY conf/notebook ${BIN_DIR}/notebook
COPY conf/notebook ${BIN_DIR}/pyspark-notebook

RUN chmod u+x ${BIN_DIR}/notebook && chmod u+x ${BIN_DIR}/pyspark-notebook

EXPOSE 8888

CMD ["notebook"]