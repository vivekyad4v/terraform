#!/bin/bash 

apt-get update -y && apt-get install apache2 -y

echo "Hello ${ORGNAME}, this is your terraform ${ENVIRON} setup using default EC2 template user data. Cheers!!" > /var/www/html/index.html

