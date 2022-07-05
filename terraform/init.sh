#!/bin/bash
echo "====================Start====================="
mkdir /app && cd /app
git clone https://github.com/innomaxx/cloudtech52_demo.git .
sudo docker compose -f "docker-compose.prod.yml" up -d
echo "====================End====================="