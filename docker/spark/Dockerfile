# syntax=docker/dockerfile:1

ARG java_image_tag=17-jammy

FROM eclipse-temurin:${java_image_tag}

ARG spark_uid=185

ENV SPARK_VERSION=3.5.2
ENV SPARK_MAJOR_VERSION=3.5
ENV HADOOP_VERSION=3
ENV SCALA_VERSION=2.12
ENV ICEBERG_VERSION=1.6.0
ENV PYTHONHASHSEED=1
ENV BIN_DIR=/usr/bin
ENV SPARK_LOG_DIR=/opt/spark/logs
ENV SPARK_MASTER_LOG=/opt/spark/logs/spark-master.out
ENV SPARK_WORKER_LOG=/opt/spark/logs/spark-worker.out
ENV SPARK_HOME=/opt/spark
ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}"
ENV INSTALL_DIR=/tmp/install

RUN set -ex && \
  ln -s /lib /lib64 && \
  apt update && \
  apt upgrade -y && \
  apt install -y --no-install-recommends \
  bash tini libc6 libpam-modules krb5-user libnss3 procps net-tools ssh rsync && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p ${SPARK_HOME} && \
  mkdir -p ${SPARK_HOME}/examples && \
  mkdir -p ${SPARK_HOME}/work-dir && \
  mkdir -p ${SPARK_LOG_DIR} && \
  mkdir -p ${INSTALL_DIR} && \
  mkdir -p /tmp/spark-events && \
  touch /opt/spark/RELEASE && \
  touch ${SPARK_MASTER_LOG} && \
  touch ${SPARK_WORKER_LOG} && \
  ln -sf /dev/stdout ${SPARK_MASTER_LOG} && \
  ln -sf /dev/stdout ${SPARK_WORKER_LOG} && \
  rm /bin/sh && \
  ln -sv /bin/bash /bin/sh && \
  echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
  chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
  rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/*

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 0600 ~/.ssh/authorized_keys

WORKDIR ${INSTALL_DIR}

# Download Apache Spark
RUN curl "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" -o "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && tar xvzf "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" --directory /opt/spark --strip-components 1 && rm "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
# Download clickhouse dependencies
RUN curl https://repo1.maven.org/maven2/com/clickhouse/spark/clickhouse-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}/0.8.0/clickhouse-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-0.8.0.jar -Lo ${SPARK_HOME}/jars/clickhouse-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-0.8.0.jar 
RUN curl https://github.com/ClickHouse/clickhouse-java/releases/download/v0.6.4/clickhouse-jdbc-0.6.4-all.jar -Lo ${SPARK_HOME}/jars/clickhouse-jdbc-0.6.4-all.jar
# Download iceberg spark runtime
RUN curl https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}/${ICEBERG_VERSION}/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}.jar -Lo ${SPARK_HOME}/jars/iceberg-spark-runtime-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-${ICEBERG_VERSION}.jar
# Download Nessie extension
RUN curl https://repo1.maven.org/maven2/org/projectnessie/nessie-integrations/nessie-spark-extensions-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}/0.95.0/nessie-spark-extensions-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-0.95.0.jar -Lo ${SPARK_HOME}/jars/nessie-spark-extensions-${SPARK_MAJOR_VERSION}_${SCALA_VERSION}-0.95.0.jar
# Download AWS dependencies
RUN curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar -Lo ${SPARK_HOME}/jars/hadoop-aws-3.3.4.jar
RUN curl https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/${ICEBERG_VERSION}/iceberg-aws-bundle-${ICEBERG_VERSION}.jar  -Lo ${SPARK_HOME}/jars/iceberg-aws-bundle-${ICEBERG_VERSION}.jar
RUN curl https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar -Lo ${SPARK_HOME}/jars/aws-java-sdk-bundle-1.12.262.jar
RUN curl https://repo1.maven.org/maven2/software/amazon/awssdk/url-connection-client/2.27.7/url-connection-client-2.27.7.jar -Lo ${SPARK_HOME}/jars/url-connection-client-2.27.7.jar
RUN curl https://repo1.maven.org/maven2/software/amazon/awssdk/s3-transfer-manager/2.27.7/s3-transfer-manager-2.27.7.jar -Lo ${SPARK_HOME}/jars/s3-transfer-manager-2.27.7.jar
# Install AWS CLI
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && unzip awscliv2.zip && sudo ./aws/install && rm awscliv2.zip && rm -rf aws/
# Download SAP HANA driver
RUN curl https://repo1.maven.org/maven2/com/sap/cloud/db/jdbc/ngdbc/2.21.11/ngdbc-2.21.11.jar -Lo ${SPARK_HOME}/jars/ngdbc.jar
# Download MSSQL jdbc
RUN curl https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/12.8.1.jre11/mssql-jdbc-12.8.1.jre11.jar -Lo ${SPARK_HOME}/jars/mssql-jdbc-12.8.1.jre11.jar
# Download MySQL jdbc
RUN curl https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.0.0/mysql-connector-j-9.0.0.jar -Lo ${SPARK_HOME}/jars/mysql-connector-j-9.0.0.jar

WORKDIR ${SPARK_HOME}

COPY conf/spark-defaults.conf ${SPARK_HOME}/conf
COPY scripts/entrypoint.sh /opt/entrypoint.sh
COPY scripts/decom.sh /opt/decom.sh

RUN chmod g+w ${SPARK_HOME}
RUN chmod a+x /opt/decom.sh
RUN chmod u+x /opt/entrypoint.sh
RUN chmod u+x ${SPARK_HOME}/* 
RUN chmod u+x ${SPARK_HOME}/bin/*

ENTRYPOINT [ "/opt/entrypoint.sh" ]

# Specify the User that the actual main process will run as
USER ${spark_uid}