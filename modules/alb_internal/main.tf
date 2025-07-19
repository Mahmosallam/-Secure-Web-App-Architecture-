# -----------------------------
# File: modules/alb_internal/main.tf
# -----------------------------

# Create Internal ALB
resource "aws_lb" "internal_alb" {
  name               = "my-interna-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = [var.private_subnet_1_id, var.private_subnet_2_id]
  security_groups    = [var.security_group_id]

  tags = {
    Name = "internal-alb"
  }
}

# Create Target Group
resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "backend-tg"
  }
}

# Create Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

# Attach backend instances
resource "aws_lb_target_group_attachment" "backend1" {
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = var.backend1_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "backend2" {
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = var.backend2_id
  port             = 80
}
