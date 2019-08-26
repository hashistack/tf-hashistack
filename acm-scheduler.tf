# ACM
## CERTIFICATE
resource "aws_acm_certificate" "scheduler" {
  domain_name = "${var.application}.${var.env_dns_zones_prefix[terraform.workspace]}${var.domain}"

  validation_method = "DNS"

  tags = {
    Name        = "scheduler.${var.application}.${var.env_dns_zones_prefix[terraform.workspace]}${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

# CERTIFICATE VALIDATION
resource "aws_acm_certificate_validation" "scheduler" {
  certificate_arn = aws_acm_certificate.scheduler.arn

  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

