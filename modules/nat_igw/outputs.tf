output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "nat_eip_id" {
  value = aws_eip.nat_eip.id
}
