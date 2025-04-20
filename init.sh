#!/bin/bash
apt update -y
apt install -y nginx
echo "<h1>Hello from Terraform</h1>" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx
