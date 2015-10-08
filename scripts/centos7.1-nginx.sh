#!/bin/bash

# update centos with patches
yum update -y --exclude=kernel

# tools
yum install -y nano git unzip screen

# nginx
yum install -y epel-release
yum install -y nginx
systemctl enable nginx.service
systemctl stop nginx.service

mv /usr/share/nginx/html /usr/share/nginx/html-orig 
ln -s /vagrant /usr/share/nginx/html

systemctl start nginx.service

# Python
sudo yum install python34

# MySQL
yum install -y mariadb-server mariadb
sudo systemctl start mariadb
sudo systemctl enable mariadb.service

mysql -u root -e "SHOW DATABASES";

# Download Starter Content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/philmui/vagrant/master/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/philmui/vagrant/master/files/info.php

systemctl restart nginx.service

# Disable firewall
systemctl stop firewalld
systemctl mask firewalld
systemctl disable iptables
systemctl disable ip6tables
