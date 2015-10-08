#!/bin/bash

# update centos with patches
yum update -y --exclude=kernel

# tools
yum install -y nano git unzip screen

# apache
yum install -y nginx
chkconfig --add nginx
chkconfig nginx on
service nginx stop

#rm -rf /var/www/html
#ln -s /vagrant /var/www/html

service httpd start

# Python
yum install -y python3 pip
pip install virtualenv

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
