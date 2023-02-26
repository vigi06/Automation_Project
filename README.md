# Automation_Project
1)When the script runs it updates the packages in the server 2) It installs apache2 in the ubuntu server as well as it starts the apache2 service also it enables the service 3) Logs which are generated in /var/log/apache2/ is tared and copied to /tmp directory 4) From tmp directory by using aws cli the logs are pushed S3 bucket

Once the above steps are complete the script checks whether the inventory file is present or not if it is not present it creates one and stores the data regarding the file and also it creates a cron job if the cron job is already not present.

Once the cron job is created it runs the script in the interval of one minute.
