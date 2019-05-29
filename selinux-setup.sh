#!/bin/bash

echo -e "Installing required packages ..."
yum install -y httpd httpd-tools setroubleshoot-server

echo -e "Create /var/www/html/index.html"
mkdir -p /var/www/html
echo "SELinux Demo -- Control Page" > /var/www/html/index.html

echo -e "Create folder and file to demo booleans"
mkdir -p /var/www/html/booleans
echo "SELinux Demo -- Booleans" > /var/www/html/booleans/index.html

echo -e "Purposely break the booleans file"
chcon -R -t home_dir_t /var/www/html/booleans/index.html

echo -e "Create folder and file to demo file labeling"
mkdir -p /var/www/html/shadow
echo "SELinux Demo -- Booleans" > /var/www/html/shadow/index.html

echo -e "Purposely break the file label"
chcon -R -t shadow_t /var/www/html/booleans/index.html

echo -e "Start apache and add firewall rule"
systemctl enable httpd
systemctl start httpd
firewall-cmd --add-service=http --permanent
firewall-cmd --reload
