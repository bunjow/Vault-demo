#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

mkdir /var/www/inc
cat <<- EOF > /var/www/inc/dbinfo.inc
<?php

define('DB_SERVER', 'db_instance_endpoint');
define('DB_USERNAME', 'tutorial_user');
define('DB_PASSWORD', 'master password');
define('DB_DATABASE', 'sample');

?>
                
EOF

# install pip
##apt-get -y install python-pip
wget -q https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
rm -f get-pip.py

# install awscli
pip install awscli
