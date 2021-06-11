resource "aws_lb" "application-lb" {
  name               = "lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.petclinic-sg.id]
  subnets            = [aws_subnet.pet-clinic-sn.id, aws_subnet.private_reserve.id]
  tags = {
    Name = "LB"
  }
}

resource "aws_lb_target_group" "app-lb-tg" {
  name        = "app-lb-tg"
  port        = 8080
  target_type = "instance"
  vpc_id      = aws_vpc.devops_lab_final.id
  protocol    = "HTTP"
  health_check {
    enabled  = true
    interval = 10
    path     = "/login"
    port     = 8080
    protocol = "HTTP"
    matcher  = "200-299"
  }
  tags = {
    Name = "target-group"
  }
}

resource "aws_lb_listener" "listener-https" {
  load_balancer_arn = aws_lb.application-lb.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.lb-https.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-lb-tg.arn
  }
}

resource "aws_lb_listener" "listener-http" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_lb_target_group.app-lb-tg.arn
  target_id        = aws_instance.pet-clinic.id
  port             = 8080
}
