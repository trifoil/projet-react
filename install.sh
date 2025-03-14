#!/bin/sh

# Define the directory and file path
DIR="./docker/mongodb"
FILE="$DIR/docker-compose.yaml"
STORAGE_DIR="$DIR/storage"

# Create the directory if it doesn't exist
mkdir -p "$STORAGE_DIR"

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
      MONGO_INITDB_ROOT_PASSWORD: test
    ports:
      - "27017:27017"
    volumes:
      - ./storage:/data/db

volumes:
  mongodb_data:
EOF

# Print success message
echo "docker-compose.yaml has been created at $FILE"

# Navigate to the directory and start the container
cd "$DIR"
sudo docker compose up -d
cd ../..