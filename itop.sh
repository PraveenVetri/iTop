#!/bin/bash

echo "Welcome to the installation script"
echo "iTop installation is begins"
apt update

echo "Installing Apache web server"
apt-get install apache2 -y

echo "Adding PHP repository"
sudo add-apt-repository ppa:ondrej/php

echo "Updating package lists again"
apt update

echo "Installing PHP and required extensions for iTop"
apt-get install php php-mysql php-ldap php-mcrypt php-cli php-soap php-json php-xml php-gd php-zip libapache2-mod-php php-mbstring php-curl -y

echo "Checking PHP version"
php -v


apt update
echo "Installing Graphviz"
apt-get install graphviz -y

echo "Installing MySQL server and client"
apt-get install mysql-server mysql-client -y

echo "Creating MySQL database and user"
mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE itop;
CREATE USER 'testuser'@'%' IDENTIFIED BY 'test@123';
GRANT ALL PRIVILEGES ON itop.* TO 'testuser'@'%';
FLUSH PRIVILEGES;
exit
MYSQL_SCRIPT

cd /var/www/html
echo "Downloading the iTop package and set up iTop"
wget https://sourceforge.net/projects/itop/files/itop/3.0.3/iTop-3.0.3-10998.zip
unzip iTop-3.0.3-10998.zip
mv web itop
rm -rf iTop-3.0.3-10998.zip
chown -R www-data:www-data itop
chmod -R 755 itop

echo "Restarting Apache"
systemctl restart apache2

echo "iTop installation completed."
echo "Access the site using http://Your_ip_address/itop"
