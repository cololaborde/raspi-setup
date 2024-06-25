#!/bin/bash

# Create necessary directories
mkdir pihole
mkdir owncloud
# mkdir env-files

# Install docker
sudo chmod +x utils/scripts/install_docker.sh
sudo ./utils/scripts/install_docker.sh

# Setup pihole
cp utils/composes/pihole.yml pihole/docker-compose.yml
cp env-files/.env.pihole pihole/.env.pihole
cd pihole
docker compose up -d
cd ..

# Setup owncloud
cp utils/composes/owncloud.yml owncloud/docker-compose.yml
cp env-files/.env.owncloud owncloud/.env.owncloud
cp env-files/.env.db owncloud/.env.db
cd owncloud
docker compose up -d
cd ..

# Install python
sudo chmod +x utils/scripts/install_python.sh
sudo ./utils/scripts/install_python.sh

# Setup onstartup actions
sudo chmod +x utils/scripts/onstartup.sh
echo  cd $HOME"/raspi-setup/utils/scripts && ./onstartup.sh &" | sudo tee -a /etc/rc.local
echo cd $HOME"/raspi-setup/utils/OLED_Stats && python3 monitor.py &" | sudo tee -a /etc/rc.local
echo exit 0 | sudo tee -a /etc/rc.local

# Reboot
echo "Setup completed. Rebooting in 5 seconds..."
sleep 5
sudo reboot
