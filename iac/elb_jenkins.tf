resource "aws_lb" "jenkins-lb" {
  name               = "jenkins-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jenkins-elb-sg.id]
  subnets            = [aws_subnet.subnet_pbl1.id, aws_subnet.subnet_pbl2.id]
  tags = {
    Name = "Jenkins-ALB"
  }
}

resource "aws_lb_target_group" "jenkins-lb-tg" {
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
    Name = "Jenkins-TG"
  }
}

resource "aws_lb_target_group_attachment" "jenkins-attach" {
  target_group_arn = aws_lb_target_group.jenkins-lb-tg.arn
  target_id        = aws_instance.jenkins-server.id
  port             = 8080
}

resource "aws_lb_listener" "listener-https" {
  load_balancer_arn = aws_lb.jenkins-lb.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.jenkins-https.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins-lb-tg.arn
  }

  tags = {
    Name = "Jenkins-Listener"
  }
}

