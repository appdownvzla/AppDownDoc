#!/bin/bash

printf "Instalando entorno de escritorio...\n"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y xfce4 xfce4-goodies desktop-base

printf "Instalando Google Chrome...\n"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y google-chrome-stable

printf "Instalando XRDP...\n"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y xrdp
sudo adduser xrdp ssl-cert

printf "Configurando escritorio remoto...\n"
echo xfce4-session >~/.xsession
sudo sed -i '0,/port=-1/s//port=ask-1/' /etc/xrdp/xrdp.ini
sudo /etc/init.d/xrdp restart

printf "Creando usuario de escritorio remoto...\n"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y sudo
sudo useradd -m user
echo "user:user" | sudo chpasswd
echo "user ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/user
sudo chmod 0440 /etc/sudoers.d/user

printf "\n\n"
printf "¡Listo! Tu servidor VPS con Colab RDP está configurado.\n"
printf "Para conectarte a tu servidor, usa un cliente de Escritorio Remoto y conecta a la dirección IP y puerto que se te proporcionó.\n"
printf "Inicia sesión con el usuario de escritorio remoto 'user' y la contraseña que hayas establecido.\n"
````