#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done


# install pip
##apt-get -y install python-pip
wget -q https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
rm -f get-pip.py

# install awscli
pip install awscli
