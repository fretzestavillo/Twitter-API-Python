#!/bin/bash

# Set environment variables
PROJECT_ID="cicd-project-412702"
IMAGE_REGISTRY="asia-southeast1-docker.pkg.dev"
TAG="latest"

echo "stop running container..."
# Stop the existing and old container
docker stop estavillofretz_script_1
docker stop estavillofretz_mysql_1

echo "removing  container..."
# Remove the existing and old container
docker rm estavillofretz_script_1
docker rm estavillofretz_mysql_1

# Remove the existing and old images
docker rmi $IMAGE_REGISTRY/$PROJECT_ID/demo/python-script:$TAG
docker rmi $IMAGE_REGISTRY/$PROJECT_ID/demo/mysql:$TAG

# Authenticate Docker to Google Artifact Registry
gcloud auth configure-docker $IMAGE_REGISTRY

# Pull new images with debugging information
docker pull $IMAGE_REGISTRY/$PROJECT_ID/demo/mysql:$TAG
docker pull $IMAGE_REGISTRY/$PROJECT_ID/demo/python-script:$TAG

rm docker-compose.yaml

echo "docker-compose.yaml file removed successfully."
echo "creating docker-compose.yaml file....."
# Create docker-compose.yaml file
cat > docker-compose.yaml <<EOF
version: '3'

services:
  mysql:
    image: $IMAGE_REGISTRY/$PROJECT_ID/demo/mysql:$TAG
    restart: always
    environment:
      MYSQL_DATABASE: 'twitter'
      MYSQL_ROOT_PASSWORD: 'root'
    ports:
      - '3306:3306'

  script:
    image: $IMAGE_REGISTRY/$PROJECT_ID/demo/python-script:$TAG
    depends_on:
      - mysql
    ports:
      - '80:80'
EOF

echo "docker-compose.yaml file created successfully."
sudo chmod +x docker-compose.yaml
echo "providing permision and run the two service"
docker-compose up -d