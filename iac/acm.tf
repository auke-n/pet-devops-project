resource "aws_acm_certificate" "lb-https" {
  domain_name       = "fl.sec.iplatinum.pro"
  validation_method = "DNS"

  tags = {
    Name = "ACM"
  }
}

resource "aws_acm_certificate_validation" "certificate" {
  timeouts {
    create = "5m"
  }
  certificate_arn         = aws_acm_certificate.lb-https.arn
  validation_record_fqdns = [for record in aws_route53_record.acm-validation : record.fqdn]
}


resource "aws_route53_record" "acm-validation" {
  for_each = {
    for dvo in aws_acm_certificate.lb-https.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = "Z00084481U441RC0QQ500"
}