sudo apt update -y
sudo apt install apache2 awscli -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo tar cf /tmp/sachin-httpd-logs-$(date '+%d%m%Y-%H%M%S').tar /var/log/apache2/*.log 
aws s3 \
cp /tmp/$(myname)-httpd-logs-$(date '+%d%m%Y-%H%M%S').tar \
s3://$(s3_bucket)/$(myname)-httpd-logs-$(date '+%d%m%Y-%H%M%S').tar

