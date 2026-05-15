resource "aws_lb" "app_alb" {
  name               = "my-app-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "my-app-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name        = "my-app-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = aws_vpc.main_vpc.id

  health_check {
    path = "/"

    healthy_threshold   = 2
    unhealthy_threshold = 2

    timeout  = 5
    interval = 30

    matcher = "200"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

