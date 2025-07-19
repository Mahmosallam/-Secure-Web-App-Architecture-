# create public subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.public_subnet_1_az
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

# create public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.public_subnet_2_az
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

# create private subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.private_subnet_1_az

  tags = {
    Name = "private-subnet-1"
  }
}

# create private subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.private_subnet_2_az

  tags = {
    Name = "private-subnet-2"
  }
}
