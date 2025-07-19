# create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "gw-for-public"
  }
}

# create elastic ip for nat gateway
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "nat-eip"
  }
}

# create nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "My-NAT-GW"
  }

  depends_on = [aws_eip.nat_eip]
}
