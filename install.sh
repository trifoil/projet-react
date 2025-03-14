#!/bin/sh

# Define the directory and file path
DIR="./docker/mongodb"
FILE="$DIR/docker-compose.yaml"

# Create the directory if it doesn't exist
mkdir -p "$DIR"

# Write the docker-compose.yaml content
cat <<EOF > "$FILE"
version: '3.8'

services:
  mongodb:
    image: mongo:latest
    container_name: mongodb
    restart: always
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example
    ports:
      - "27017:27017"
    volumes:
      - mongodb_data:/data/db

volumes:
  mongodb_data:
EOF

# Print success message
echo "docker-compose.yaml has been created at $FILE"
