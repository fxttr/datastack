#!/bin/bash

IMAGE_NAME="sparkbase"
DOCKERFILE_PATH="spark/spark/Dockerfile.base"
SERVICES=("spark-master" "spark-worker-01" "spark-worker-02" "playground")

build_image() {
  echo "Building $IMAGE_NAME ..."
  docker build -t $IMAGE_NAME -f $DOCKERFILE_PATH .
  
  if [ $? -ne 0 ]; then
    echo "Error while building $IMAGE_NAME."
    exit 1
  fi

  echo "$IMAGE_NAME build successfully."
}

restart_services() {
  for SERVICE in "${SERVICES[@]}"; do
    echo "Restarting $SERVICE ..."
    docker-compose up -d --no-deps --build $SERVICE
    
    if [ $? -ne 0 ]; then
      echo "Error while restarting $SERVICE."
      exit 1
    fi
    
    echo "$SERVICE restarted successfully."
  done
}

# Hauptablauf
build_image
restart_services

echo "Done."
