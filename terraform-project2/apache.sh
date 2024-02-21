#!/bin/bash
# Update system packages
apt-get update -y
# Install Apache Web Server
apt-get install -y apache2
# Start the Apache service
systemctl start apache2.service
# Enable Apache service to start on boot
systemctl enable apache2.service
# Optional: Add custom content to the web server's default page
echo "<html><h1>Welcome to the Web Server</h1></html>" > /var/www/html/index.html
