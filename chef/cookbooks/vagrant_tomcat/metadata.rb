name 'vagrant_tomcat'
maintainer 'Phil Mui'
maintainer_email 'thephilmui@gmail.com'
license 'Apache 2.0'
description 'Customize Tomcat-Latest Cookbook for Vagrant'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'

depends 'java'
depends 'tomcat_latest'

supports 'centos'

recipe 'vagrant_tomcat::default, 'Updates Tomcat installation'