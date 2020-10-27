#!/bin/bash
mkdir -p /var/www/inc
cat << EOF > /var/www/inc/dbinfo.inc
<?php

define('DB_SERVER', 'sample');
define('DB_USERNAME', 'webapp');
define('DB_PASSWORD', '<what is my password>');
define('DB_DATABASE', '<where is my database>');

?>
EOF
