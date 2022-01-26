##### vars 
myname=sachin
s3_bucket=upgrad-sachin
git_repo=Automation_Project
sudo apt update -y
sudo apt install awscli
#installing apache2 and awscli
if ! command -v apache2; then sudo apt install apache2 -y && echo apache installed; fi
# checks the status of apache2 if not started then starts
if ! ps -C apache2; then sudo systemctl start apache2 && echo apache service started; fi
sudo systemctl enable apache2
dateofarchive=$(date '+%d%m%Y-%H%M%S')
cd /var/log/apache2/ && tar cf /tmp/sachin-httpd-logs-$dateofarchive.tar  *.log
#aws s3 \
#cp /tmp/$(myname)-httpd-logs-$dateofarchive.tar \
#s3://$(s3_bucket)/$(myname)-httpd-logs-$dateofarchive.tar


########## checks inventory.html and created if not present ######## 
if [ ! -f /var/www/html/inventory.html ];  then sudo bash -c "echo -e 'Log Type\tTime Created\tType\tSize' > /var/www/html/inventory.html" ; fi	

### entering data in file ######
sudo bash -c "echo 'httpd-logs   $dateofarchive     tar     $(du -sh /tmp/sachin-httpd-logs-$dateofarchive.tar | awk '{print$1}')' >> /var/www/html/inventory.html" 
echo "------------data entered in inventory file---------------"
echo script completed 

##### creating cronjob #########
if [ ! -f /etc/cron.d/automation ];  then sudo bash -c "echo -e '0 0 * * *\t/root/$git_repo/automation.sh' > /etc/cron.d/automation" && echo script created ; fi

