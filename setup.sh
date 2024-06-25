#!/bin/bash

# Create necessary directories
mkdir pihole
mkdir owncloud
mkdir env-files

# Install docker
sudo chmod +x utils/scripts/install_docker.sh
sudo ./utils/scripts/install_docker.sh


cp utils/composes/pihole.yml pihole/docker-compose.yml
cd pihole
docker compose up -d

cd ..
cp utils/composes/owncloud.yml owncloud/docker-compose.yml
cd owncloud
docker compose up -d
cd..

# Install python

sudo chmod +x utils/scripts/install_python.sh
sudo ./utils/scripts/install_python.sh

sudo chmod +x utils/scripts/onstartup.sh
echo  cd $HOME"/raspi-setup/utils/scripts && ./onstartup.sh &" | sudo tee -a /etc/rc.local
echo cd $HOME"/raspi-setup/utils/OLED_Stats && python3 monitor.py &" | sudo tee -a /etc/rc.local
echo exit 0 | sudo tee -a /etc/rc.local

echo "Setup completed. Rebooting in 5 seconds..."
sleep 5
sudo reboot
