#!/bin/bash

# Define the content of the docker-compose.yml file
DOCKER_COMPOSE_CONTENT='
version: "3"
services:
  app:
    container_name: app
    restart: always
    image: braineanear/ecommerceapi:latest  # Replace with the correct image name if needed
    environment:
      - PORT=4002
      - MONGO_URI=mongodb://mongo:27017/ecommerce  # MongoDB connection string
    ports:
      - "8081:8081"
    depends_on:
      - mongo

  mongo:
    container_name: mongo
    image: mongo:latest
    restart: always
    environment:
      - MONGO_INITDB_DATABASE=ecommerce
    volumes:
      - mongo-data:/data/db
    ports:
      - "27017:27017"

volumes:
  mongo-data:
'

# Create the docker-compose.yml file
echo "$DOCKER_COMPOSE_CONTENT" > docker-compose.yml

# Pull the latest images
docker compose pull

# Deploy the Docker containers
docker compose up -d

# Check if the deployment was successful
if [ $? -eq 0 ]; then
  echo "Deployment successful!"
else
  echo "Deployment failed. Please check the logs."
fi