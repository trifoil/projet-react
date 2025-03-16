#!/bin/sh

Define the directory and file path
DIR="./docker/api"
FILE="$DIR/docker-compose.yaml"

# Create the directory if it doesn't exist

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

volumes:
  db:
EOF

# Print success message
echo "docker-compose.yaml has been created at $FILE"

# Navigate to the directory and start the container
cd "$DIR"
sudo docker compose up -d
cd ../..

#pull
docker pull liyasthomas/postwoman

#run
docker run -d -p 3001:3000 liyasthomas/postwoman:latest

#build
#docker build -t postwoman:latest