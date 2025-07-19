#!/bin/bash

# Update system
sudo yum update -y

# Install Nginx
sudo yum install -y httpd

# Start and enable Nginx
sudo systemctl start httpd
sudo systemctl enable httpd

# Create web page
sudo mkdir -p /var/www/html
sudo tee /var/www/html/index.html > /dev/null <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Backend Web App</title>
    <style>
        body {
            background: linear-gradient(to bottom right, #4e54c8, #8f94fb);
            color: #fff;
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 100px;
        }
        h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }
        p {
            font-size: 24px;
        }
        .signature {
            margin-top: 40px;
            font-weight: bold;
            color: #ffeeba;
        }
    </style>
</head>
<body>
    <h1>Private Backend Web App</h1>
    <p>This is a static HTML page served by Nginx from a private EC2 backend.</p>
    <p class="signature">From Mahmoud Sallam — wuba luba dup dup 💥</p>
</body>
</html>
EOF
