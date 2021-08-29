# Automation_Project
Automation project for DevOps Essentials Assignment
This repository containts the aurtomation script which will automate the following:
1. Update all the packages
2. Install Apache2
3. Check if Apache2 is running or not
4. Restart Apache2 after the system has rebooted
5. Create tar for Apache logs and uploads them to S3 bucket and store the size of the tar file in a variable
6. Log all the uploads for S3 bucket in inventory.html
7. Update the existing automation.sh to create a cron job if it is not present
8. This cron job would execute the automation.sh every day
