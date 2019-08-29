#!/bin/bash

echo -e "Installing required packages ..."
yum install -y httpd httpd-tools setroubleshoot-server

echo -e "Create /var/www/html/index.html"
mkdir -p /var/www/html
echo "SELinux Demo -- Control Page" > /var/www/html/index.html
echo '<br>' >> /var/www/html/index.html
echo '<a href="booleans.html">SELinux Demo -- Booleans</a>' >> /var/www/html/index.html
echo '<br>' >> /var/www/html/index.html
echo '<a href="shadow.html">SELinux Demo -- Labeling</a>' >> /var/www/html/index.html

echo -e "Create file to demo booleans"
echo "SELinux Demo -- Booleans" > /var/www/html/booleans.html
echo "<br>If you see this page = SUCCESS!" >> /var/www/html/booleans.html

echo -e "Purposely break the booleans file"
chcon -t user_home_t /var/www/html/booleans.html

echo -e "Create file to demo file labeling"
echo "SELinux Demo -- Labeling" > /var/www/html/shadow.html
echo "<br>If you see this page = SUCCESS!" >> /var/www/html/shadow.html

echo -e "Purposely break the file label"
chcon -t shadow_t /var/www/html/shadow.html

echo -e "Start apache and add firewall rule"
systemctl enable httpd
systemctl start httpd
firewall-cmd --add-service=http --permanent
firewall-cmd --reload
