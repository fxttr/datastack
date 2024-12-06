# syntax=docker/dockerfile:1
FROM ghcr.io/fxttr/sparkbase:latest

RUN apt update && apt upgrade -y && \
  apt install -y --no-install-recommends \
  python3 \
  python3-pip

ENV DBT_DIR=/var/lib/fxttr/dbt
ENV NOTEBOOKS_DIR=/var/lib/fxttr/notebooks
ENV IJAVA_CLASSPATH=$SPARK_HOME/jars/*

RUN mkdir -p ${DBT_DIR} ${NOTEBOOKS_DIR} /root/.ipython/profile_default/startup

# Install python deps
COPY conf/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && rm requirements.txt

# Download and install IJava jupyter kernel
RUN curl https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip -Lo ijava-1.3.0.zip \
  && unzip ijava-1.3.0.zip \
  && python3 install.py --sys-prefix \
  && rm -rf ijava-1.3.0.zip	install.py java 

WORKDIR ${NOTEBOOKS_DIR}

COPY conf/ipython/startup/00-prettytables.py /root/.ipython/profile_default/startup
COPY conf/ipython/startup/README /root/.ipython/profile_default/startup
COPY conf/notebook ${BIN_DIR}/notebook
COPY conf/notebook ${BIN_DIR}/pyspark-notebook

RUN chmod u+x ${BIN_DIR}/notebook && chmod u+x ${BIN_DIR}/pyspark-notebook

EXPOSE 8888

CMD ["notebook"]