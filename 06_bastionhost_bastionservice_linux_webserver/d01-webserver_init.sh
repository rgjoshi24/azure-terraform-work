#! /bin/bash
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install apache2 -y
echo "<h1><center>Sample website using Azure & Terraform</center></h1>" > index.html
sudo mv index.html /var/www/html/
sudo service apache2 restart