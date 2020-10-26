#!/bin/bash
mkdir -p /var/www/inc
cat << EOF > /var/www/inc/dbinfo.inc
<?php

define('DB_SERVER', '$DBServer');
define('DB_USERNAME', '$DBUserName');
define('DB_PASSWORD', '$DBPassword');
define('DB_DATABASE', '$DBDatabase');

?>
echo "Bobs your uncle"
EOF
