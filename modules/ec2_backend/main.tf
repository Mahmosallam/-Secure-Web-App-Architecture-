# Create EC2 instance 1 (backend1)
resource "aws_instance" "backend1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_1_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false
  key_name                    = var.key_name

  tags = {
    Name = "backend-1"
  }

  # Copy install script
  provisioner "file" {
    source      = "install_backend.sh"
    destination = "/tmp/install_backend.sh"

    connection {
      type                = "ssh"
      user                = "ec2-user"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.bastion_host
      bastion_user        = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }

  # Execute script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_backend.sh",
      "sudo /tmp/install_backend.sh"
    ]

    connection {
      type                = "ssh"
      user                = "ec2-user"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.bastion_host
      bastion_user        = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }
}

# Create EC2 instance 2 (backend2)
resource "aws_instance" "backend2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_2_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false
  key_name                    = var.key_name

  tags = {
    Name = "backend-2"
  }

  # Copy install script
  provisioner "file" {
    source      = "install_backend.sh"
    destination = "/tmp/install_backend.sh"

    connection {
      type                = "ssh"
      user                = "ec2-user"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.bastion_host
      bastion_user        = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }

  # Execute script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_backend.sh",
      "sudo /tmp/install_backend.sh"
    ]

    connection {
      type                = "ssh"
      user                = "ec2-user"
      private_key         = file(var.private_key_path)
      host                = self.private_ip
      bastion_host        = var.bastion_host
      bastion_user        = "ec2-user"
      bastion_private_key = file(var.private_key_path)
    }
  }
}
