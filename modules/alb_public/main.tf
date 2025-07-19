# create public alb
resource "aws_lb" "public_alb" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.public_subnet_1_id, var.public_subnet_2_id]

  tags = {
    Name = "public-alb"
  }
}

# create target group
resource "aws_lb_target_group" "tg" {
  name     = "proxy-targets"
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
    Name = "tg-for-proxies"
  }
}

# attach proxy 1
resource "aws_lb_target_group_attachment" "proxy1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.proxy1_id
  port             = 80
}

# attach proxy 2
resource "aws_lb_target_group_attachment" "proxy2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.proxy2_id
  port             = 80
}

# create listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
