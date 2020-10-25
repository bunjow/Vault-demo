#!/bin/bash

curl ifconfig.me|awk '{print $1 "/32"}' > myPublicIP.txt

