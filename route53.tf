# ROUTE53
data "aws_route53_zone" "main" {
  name = "${var.env_dns_zones_prefix[terraform.workspace]}${var.domain}."
}
