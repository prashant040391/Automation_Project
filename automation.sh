#Variable declaration
myName="Prashant"
s3_bucket="upgrad-prashant"
timestamp=$(date '+%d%m%Y-%H%M%S')

#Update the package
sudo apt update -y

#Install Apache2
sudo apt-get install apache2

#Check for Apache2
service apache2 status

#Restart Apache2
systemctl restart apache2.service

#Move to Apache directory
cd /var/log/apache2/

#Create tar for log files
tar -cvzf $myName-httpd-logs-$timestamp.tar access.log error.log other_vhosts_access.log

#Move the tar file to /tmp/ directory
mv $myName-httpd-logs-$timestamp.tar /tmp/

#Upload the tar file in the S3 bucket
aws s3 cp /tmp/$myName-httpd-logs-$timestamp.tar s3://$s3_bucket/$myName-httpd-logs-$timestamp.tar