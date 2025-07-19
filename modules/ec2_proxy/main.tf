# -------------------------------
# EC2 Instance - Reverse Proxy 1
# -------------------------------
resource "aws_instance" "proxy1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_1_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true
  key_name               = var.key_name

  tags = {
    Name = "reverse-proxy-1"
  }


provisioner "local-exec" {
    command = "echo public ip for proxy 1 is: ${self.public_ip} >> all_ips.txt"
  

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }


provisioner "remote-exec" {
  inline = [
    "sudo amazon-linux-extras enable nginx1",
    "sudo yum clean metadata",
    "sudo yum install -y nginx",
    "echo 'server {\n  listen 80;\n  location / {\n    proxy_pass http://${var.backend_alb_dns};\n  }\n}' | sudo tee /etc/nginx/conf.d/default.conf",
    "sudo systemctl enable --now nginx"
  ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}

# -------------------------------
# EC2 Instance - Reverse Proxy 2
# -------------------------------
resource "aws_instance" "proxy2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_2_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true
  key_name               = var.key_name

  tags = {
    Name = "reverse-proxy-2"
  }

  provisioner "local-exec" {
    command = "echo public ip for proxy 2 is: ${self.public_ip} >> all_ips.txt"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

 provisioner "remote-exec" {
  inline = [
    "sudo amazon-linux-extras enable nginx1",
    "sudo yum clean metadata",
    "sudo yum install -y nginx",
    "echo 'server {\n  listen 80;\n  location / {\n    proxy_pass http://${var.backend_alb_dns};\n  }\n}' | sudo tee /etc/nginx/conf.d/default.conf",
    "sudo systemctl enable --now nginx"
  ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}
