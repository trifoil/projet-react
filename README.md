# projet-react

Init

```sh
sudo rm -rf projet-react
sudo dnf install git -y
git clone https://github.com/trifoil/projet-react.git


sudo dnf remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo docker run hello-world

sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts

cd projet-react
sudo sh install.sh
```

Start the project

```sh
npm create vite@latest toto -- --template react
cd toto
npm install
npm run dev
```


In Postwoman, make sure you format the url as (localhost won't work since it is in a docker network) :

```
http://192.168.124.237:3000/api/auth/register
```

The script asks you to provide :

```
CLOUD_NAME
CLOUD_API_KEY
CLOUD_API_SECRET
CLOUD_PROJECT
```