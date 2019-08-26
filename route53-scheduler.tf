# ROUTE53
## RECORDS
resource "aws_route53_record" "scheduler" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.application}.${var.env_dns_zones_prefix[terraform.workspace]}${var.domain}"
  type    = "A"

  alias {
    name                   = aws_elb.scheduler.dns_name
    zone_id                = aws_elb.scheduler.zone_id
    evaluate_target_health = "false"
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.scheduler.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.scheduler.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.main.id
  records = [aws_acm_certificate.scheduler.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

