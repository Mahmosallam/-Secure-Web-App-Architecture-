# -----------------------------
# File: modules/alb_internal/outputs.tf
# -----------------------------

output "alb_dns_name" {
  value = aws_lb.internal_alb.dns_name
}

