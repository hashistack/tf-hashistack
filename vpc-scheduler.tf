# VPC
## SECURITY GROUP ELB
resource "aws_security_group" "scheduler-elb" {
  name        = "${var.application}-scheduler-elb.${terraform.workspace}.${var.domain}"
  description = "${var.application}-scheduler-elb security group"

  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}-scheduler-elb.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

resource "aws_security_group_rule" "in-anywhere_4646_scheduler-elb" {
  type = "ingress"

  protocol = "tcp"

  from_port = "4646"
  to_port   = "4646"

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.scheduler-elb.id
}

## SECURITY GROUPS
resource "aws_security_group" "scheduler" {
  name        = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"
  description = "${var.application}-scheduler security group"

  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}
