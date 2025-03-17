#!/bin/sh


dnf remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

dnf -y install dnf-plugins-core
dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable --now docker
docker run hello-world

docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts


# Define the directory and file path
DIR="./docker/api"
FILE="$DIR/docker-compose.yaml"
ENV_FILE="$DIR/test.env"

# Create the directory if it doesn't exist
mkdir -p "$DIR"

# Set default values for environment variables
DEFAULT_CLOUD_NAME="dtthivula"
DEFAULT_CLOUD_API_KEY="test"
DEFAULT_CLOUD_API_SECRET="test"
DEFAULT_CLOUD_PROJECT="test"

# Prompt the user for environment variables with defaults
echo "Please enter the following details for your cloud service (defaults are provided):"
read -p "CLOUD_NAME [$DEFAULT_CLOUD_NAME]: " CLOUD_NAME
CLOUD_NAME=${CLOUD_NAME:-$DEFAULT_CLOUD_NAME}

read -p "CLOUD_API_KEY [$DEFAULT_CLOUD_API_KEY]: " CLOUD_API_KEY
CLOUD_API_KEY=${CLOUD_API_KEY:-$DEFAULT_CLOUD_API_KEY}

read -p "CLOUD_API_SECRET [$DEFAULT_CLOUD_API_SECRET]: " CLOUD_API_SECRET
CLOUD_API_SECRET=${CLOUD_API_SECRET:-$DEFAULT_CLOUD_API_SECRET}

read -p "CLOUD_PROJECT [$DEFAULT_CLOUD_PROJECT]: " CLOUD_PROJECT
CLOUD_PROJECT=${CLOUD_PROJECT:-$DEFAULT_CLOUD_PROJECT}

# Write the environment variables to test.env
cat <<EOF > "$ENV_FILE"
# Main Configurations
NODE_ENV=development
PORT=3000

# Database Configurations
DATABASE_CONNECTION=mongodb://root:test@mongodb:27017/
DATABASE_USERNAME=root
DATABASE_PASSWORD=test
DATABASE_PORT=27017

# JWT Configurations
JWT_SECRET=test
JWT_ACCESS_EXPIRATION_MINUTES=60
JWT_REFRESH_EXPIRATION_DAYS=1
JWT_RESET_PASSWORD_EXPIRATION_MINUTES=6000
JWT_VERIFY_EMAIL_EXPIRATION_MINUTES=6000

# Cloudinary Configurations
CLOUD_NAME=$CLOUD_NAME
CLOUD_API_KEY=$CLOUD_API_KEY
CLOUD_API_SECRET=$CLOUD_API_SECRET
CLOUD_PROJECT=$CLOUD_PROJECT
EOF
echo "Environment variables have been written to $ENV_FILE"

# Write the docker-compose.yaml content
cat <<EOF > "$FILE"
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
      - ./test.env  # Load environment variables from test.env

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