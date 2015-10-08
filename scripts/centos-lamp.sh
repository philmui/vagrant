#!/bin/bash

# update centos with patches
yum update -y --exclude=kernel

# tools
yum install -y nano git unzip screen

# apache
yum install -y httpd httpd-devel httpd-tools
chkconfig --add httpd
chkconfig httpd on
service httpd stop

rm -rf /var/www/html
ln -s /vagrant /var/www/html

service httpd start

# PHP
yum install -y php php-cli php-common php-devel php-mysql

# Python                                                                                                                       cd /opt
sudo wget --no-check-certificate -q https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
sudo tar xf Python-2.7.10.tgz
cd Python-2.7.10
sudo ./configure --prefix=/usr/local
sudo make && sudo make altinstall

sudo wget https://bootstrap.pypa.io/get-pip.py
sudo /usr/local/bin/python2.7 get-pip.py

sudo pip install virtualenv

# MySQL
yum install -y mysql mysql-server mysql-devel
chkconfig --add mysqld
chkconfig mysqld on

service mysqld start

mysql -u root -e "SHOW DATABASES";

# Download Starter Content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/philmui/vagrant/master/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/philmui/vagrant/master/files/info.php

service httpd restart
