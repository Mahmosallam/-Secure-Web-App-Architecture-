#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Replace default config
cat <<EOF | sudo tee /etc/nginx/conf.d/reverse-proxy.conf
${nginx_config}
EOF

sudo systemctl restart nginx
