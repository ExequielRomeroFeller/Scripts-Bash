#!/bin/bash

echo "Para la instalación de GLPI necesitamos acceder a paquetes en de la web oficial"
echo "Necesitaremos que ingrese su usuario y contraseña para acceder por PROXY"
echo "Ingrese su usuario: "
read USUARIO
echo "Ingrese su contraseña: "
read PASS

#Habilitamos el proxy
export http_proxy="http://$USUARIO:$PASS@10.2.1.199:3128"
export https_proxy="http://$USUARIO:$PASS@10.2.1.199:3128"
export no_proxy="mirror.santafe.gov.ar"

#Instalamos apache y base de datos
apt install -y apache2 mariadb-server

#instalamos php 8.2
apt install -y lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -
apt-get update
apt install -y php8.2 libapache2-mod-php8.2 libsodium23 php-common php8.2-cli php8.2-common php8.2-apache php8.2-ldap 
apt install -y php8.2-mysqli php8.2-dom php8.2-simplexml php8.2-xmlreader php8.2-xmlwriter php8.2-curl php8.2-gd php8.2-bz2 php8.2-zip php8.2-mbstring 


#instalamos GLPI version 10
rm /var/www/html/index.html
cd /var/www/html/
mv /home/administrador/script/glpi-10.0.11.tgz /var/www/html/
tar -xvf glpi-10.0.11.tgz
chown -R root:root glpi
chmod 777 -R glpi




