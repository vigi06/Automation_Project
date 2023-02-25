#!/bin/bash
myname="vegnesh"
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket="upgrad-vegnesh"

sudo apt update -y
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo tar -czvf /tmp/${myname}-httpd-logs-${timestamp}.tar.gz /var/log/apache2/*.log
aws s3 cp /tmp/$myname-httpd-logs-${timestamp}.tar.gz s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar.gz
