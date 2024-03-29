#!/bin/bash

echo -e "Stop and disable apache"
systemctl disable httpd
systemctl stop httpd

echo -e "Removing packages ..."
yum erase -y httpd httpd-tools

echo -e "Remove dir /var/www/html"
rm -rf /var/www/html

echo -e "Remove firewall rule"
firewall-cmd --remove-service=http --permanent
firewall-cmd --reload

echo -e "Reset SELinux boolean"
setsebool -P httpd_read_user_content 0
