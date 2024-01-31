#!/bin/bash

#Agregamos el repositorio de la secretaría de tecnología
wget http://mirror.santafe.gov.ar/listas/sources.list.debian11 -O /etc/apt/sources.list

#Actualizamos la lista de paquetes y las últimas actualizaciones
apt update && apt upgrade -y

#Deshabilitamos la hibernación y suspención del servidor
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

#Instalamos paquetes para administración y herramientas de seguridad para el servidor
apt install mc zip ufw nmap tcpdump gparted screen -y

###Configuración del Firewall###
#Estos comandos establecen los valores predeterminados para denegar conexiones entrantes y permitir conexiones salientes. 
ufw default deny incoming
ufw default allow outgoing

#Permitimos el ingreso ssh al puerto 22 a la red de informática
ufw allow from 10.2.1.0/24 to any port 22

#Activamos el firewall
ufw enable


