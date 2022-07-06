#!/bin/bash
echo "====================Start====================="
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
mkdir app && cd app
git clone https://github.com/innomaxx/cloudtech52_demo.git .
git checkout feature/hide_creds
sudo docker compose -f "docker-compose.prod.yml" up -d
echo "====================End====================="