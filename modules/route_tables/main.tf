# create route table for public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "My-RouteTable"
  }
}

# associate route table with public subnet 1
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = var.public_subnet_1_id
  route_table_id = aws_route_table.public_rt.id
}

# associate route table with public subnet 2
resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = var.public_subnet_2_id
  route_table_id = aws_route_table.public_rt.id
}

# create route table for private subnet
resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "private-rt"
  }
}

# associate route table with private subnet 1
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = var.private_subnet_1_id
  route_table_id = aws_route_table.private_rt.id
}

# associate route table with private subnet 2
resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = var.private_subnet_2_id
  route_table_id = aws_route_table.private_rt.id
}
