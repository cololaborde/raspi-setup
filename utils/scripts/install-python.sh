#!/bin/bash

# Actualizar el índice de paquetes
sudo apt-get update

# Instalar Python 3
sudo apt-get install -y python3

# Instalar pip para Python 3
sudo apt-get install -y python3-pip

# Verificar la instalación de pip
python3 -m pip --version

echo "Python y pip se han instalado correctamente."
