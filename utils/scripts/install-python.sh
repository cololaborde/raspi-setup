#!/bin/bash

# Actualizar el índice de paquetes
sudo apt-get update

# Instalar las dependencias necesarias para agregar nuevos repositorios
sudo apt-get install -y software-properties-common

# Agregar el repositorio de Python
sudo add-apt-repository -y ppa:deadsnakes/ppa

# Actualizar el índice de paquetes nuevamente después de agregar el nuevo repositorio
sudo apt-get update

# Instalar Python (puedes especificar una versión específica si lo deseas)
sudo apt-get install -y python3.9 python3.9-venv python3.9-dev

# Establecer python3.9 como la versión predeterminada de python3
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

# Verificar la instalación de Python
python3 --version

# Instalar pip para Python 3
sudo apt-get install -y python3-pip

# Verificar la instalación de pip
pip3 --version

echo "Python y pip se han instalado correctamente."
