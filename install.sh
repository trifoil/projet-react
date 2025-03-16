#!/bin/sh

# Define the directory and file path
DIR="./docker/api"
FILE="$DIR/docker-compose.yaml"

# Create the directory if it doesn't exist
mkdir -p "$DIR"

# Write the docker-compose.yaml content
cat <<EOF > "$FILE"
version: '3.6'
services:
  backend:
    build: 
      context: .
      dockerfile: Dockerfile
    restart: always
    ports:
      - 3000:3000  # Map port 3000 on the host to port 3000 in the container
    image: ecommerceapi:latest
    stdin_open: true
    env_file:
      - ./test.env  # Load environment variables from example.env

  mongodb:
    image: mongo
    restart: always
    environment:
      - MONGO_INITDB_ROOT_USERNAME=root  # Set root username
      - MONGO_INITDB_ROOT_PASSWORD=test  # Set root password
    ports:
      - 27017:27017  # Map port 27017 on the host to port 27017 in the container
    volumes:
      - ./storage/db:/data/db  # Store MongoDB data in ./storage/db on the host
    stdin_open: true
    tty: true

  postwoman:
    image: liyasthomas/postwoman:latest
    restart: always
    ports:
      - 3001:3000  # Map port 3001 on the host to port 3000 in the container

volumes:
  db:
EOF
echo "docker-compose.yaml has been created at $FILE"

cd "$DIR"
sudo docker compose up -d
echo "Dockers pulling and starting"
cd ../..