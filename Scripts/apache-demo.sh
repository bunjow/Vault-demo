#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install apache
apt-get update
apt-get install -y apache2 php libapache2-mod-php  php-mysql

# make sure nginx is started
service apache2 restart
