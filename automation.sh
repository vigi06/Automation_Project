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

if [ ! -f /var/www/html/inventory.html ];
then
	sudo touch /var/www/html/inventory.html
		sudo echo 'Log type     Date Created       Type   Size' > /var/www/html/inventory.html;

fi

logsName=$(ls -lrths /tmp | grep ".tar" | awk -F ' ' '{print $10}' | awk -F '-' '{print $2"-"$3}')
realtime=$(ls -lrths /tmp | grep ".tar" | awk -F ' ' '{print $10}' | awk -F '-' '{print $4"-"$5}' | sed 's/\.tar\.gz//')
filetype=$(ls -lrths /tmp | grep ".tar" | awk -F ' ' '{print $10}' | awk -F '.' '{print $2}')
filesize=$(ls -lrth /tmp | grep ".tar" | awk -F ' ' '{print $5}')


sudo echo "$logsName   $realtime    $filetype    $filesize"  >> /var/www/html/inventory.html


sudo rm -rf /tmp/*.gz


if [ ! -f /etc/cron.d/automation ];
then
	sudo touch /etc/cron.d/automation
		sudo echo '* * * * *   root /root/Automation_Project/automation.sh' > /etc/cron.d/automation;
fi
