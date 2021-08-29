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
tar -cvzf $myName-httpd-logs-$timestamp.tar *.log

#Move the tar file to /tmp/ directory and get the file size
mv $myName-httpd-logs-$timestamp.tar /tmp/
fileSize=$(ls -lah "/tmp/$myName-httpd-logs-$timestamp.tar" |cut -d ' ' -f 5)

#Upload the tar file in the S3 bucket
aws s3 cp /tmp/$myName-httpd-logs-$timestamp.tar s3://$s3_bucket/$myName-httpd-logs-$timestamp.tar

#Check if Inventory.html exist or not. If not, create it
if [[ ! -e  /var/www/html/inventory.html ]]; then
    mkdir -p  /var/www/html/
    touch /var/www/html/inventory.html
fi

#Create log file for S3 Logs
echo "httpd-logs        $timestamp      tar     $fileSize" >> /var/www/html/inventory.html


#Create Cron job to execute the script
if [ ! -f /etc/cron.d/automation ]; then
        echo -e "0 */24 * * * root /root/Automation_Project/automation.sh" >> /etc/cron.d/automation
fi
