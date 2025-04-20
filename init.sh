#!/bin/bash
apt update -y
apt install -y nginx
echo "<h1>Hello from Terraform EC2</h1>" > /var/www/html/index.html
