output "backend1_private_ip" {
  value = aws_instance.backend1.private_ip
}

output "backend2_private_ip" {
  value = aws_instance.backend2.private_ip
}


output "backend1_id" {
  value = aws_instance.backend1.id
}

output "backend2_id" {
  value = aws_instance.backend2.id
}
