#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install apache
apt-get update
apt-get -y install apache2
apt-get -y install php-mysql
apt-get -y install php
apt-get -y mariadb-client-core-10.1
apt-get -y install unzip

# make sure nginx is started
service apache2 restart
