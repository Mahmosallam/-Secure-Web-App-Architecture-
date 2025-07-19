variable "vpc_id" {
  type        = string
  description = "VPC ID to attach subnets"
}

# public subnet 1
variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_1_az" {
  type = string
}

# public subnet 2
variable "public_subnet_2_cidr" {
  type = string
}

variable "public_subnet_2_az" {
  type = string
}

# private subnet 1
variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_1_az" {
  type = string
}

# private subnet 2
variable "private_subnet_2_cidr" {
  type = string
}

variable "private_subnet_2_az" {
  type = string
}
