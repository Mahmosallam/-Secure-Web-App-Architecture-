variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "private_key_path" {}
variable "private_subnet_1_id" {}
variable "private_subnet_2_id" {}
variable "security_group_id" {}
variable "bastion_host" {
  description = "Public IP of bastion EC2 (proxy1)"
}

