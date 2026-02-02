resource "aws_lb" "alb" {
  name               = "${local.app_name}-alb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.all.ids
  security_groups    = [data.aws_security_group.alb_sg.id]
}

resource "aws_lb_target_group" "app_tg" {
  name        = "${local.app_name}-tg-v2"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
