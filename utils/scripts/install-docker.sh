#!/bin/bash

# Actualizar el índice de paquetes
sudo apt-get update

# Instalar paquetes necesarios para permitir que apt use un repositorio sobre HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Agregar la clave GPG oficial de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Configurar el repositorio estable de Docker
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Actualizar el índice de paquetes nuevamente
sudo apt-get update

# Instalar la última versión de Docker CE
sudo apt-get install -y docker-ce

# Verificar que Docker esté instalado correctamente
sudo docker --version

# Habilitar y arrancar el servicio de Docker
sudo systemctl enable docker
sudo systemctl start docker

# Añadir el usuario actual al grupo docker para evitar usar sudo en los comandos de docker
sudo usermod -aG docker $USER

echo "Docker se ha instalado correctamente. Es posible que necesites reiniciar tu sesión para aplicar los cambios de grupo."
