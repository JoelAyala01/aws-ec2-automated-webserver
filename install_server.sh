#!/bin/bash
dnf update -y
dnf install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>¡Hola Mundo desde mi servidor automatizado en AWS!</h1>" > /var/www/html/index.html
