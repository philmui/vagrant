#!/bin/bash

# update centos with patches
yum update -y --exclude=kernel

# tools
yum install -y nano git unzip screen

# nginx
yum install -y epel-release
yum install -y nginx
chkconfig --add nginx
chkconfig nginx on
service nginx stop

mv /usr/share/nginx/html /usr/share/nginx/html-orig 
ln -s /vagrant /usr/share/nginx/html

service nginx start

# Python
if [ ! -e /usr/local/bin/python2.7 ] then
    cd /opt
    sudo wget --no-check-certificate -q https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
    sudo tar xf Python-2.7.10.tgz
    cd Python-2.7.10
    sudo ./configure --prefix=/usr/local
    sudo make && sudo make altinstall
fi

if [ ! -e /usr/local/bin/pip ] then
    sudo wget https://bootstrap.pypa.io/get-pip.py
    sudo /usr/local/bin/python2.7 get-pip.py
fi

if [ ! -e /usr/local/bin/virtualenv ] then
    sudo /usr/local/bin/pip install virtualenv
fi

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

service nginx restart
service iptables stop
chkconfig --level 123456 iptables off
