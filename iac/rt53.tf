resource "aws_route53_record" "jenkins-rt53" {
  zone_id = "Z00084481U441RC0QQ500"
  name    = "cicd.sec.iplatinum.pro"
  type    = "A"

  alias {
    name                   = aws_lb.jenkins-lb.dns_name
    zone_id                = aws_lb.jenkins-lb.zone_id
    evaluate_target_health = true
  }
}