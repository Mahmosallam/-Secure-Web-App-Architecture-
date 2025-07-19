output "proxy1_public_ip" {
  value = aws_instance.proxy1.public_ip
}

output "proxy2_public_ip" {
  value = aws_instance.proxy2.public_ip
}

output "proxy1_id" {
  value = aws_instance.proxy1.id
}

output "proxy2_id" {
  value = aws_instance.proxy2.id
}



