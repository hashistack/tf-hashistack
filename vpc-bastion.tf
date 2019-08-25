# VPC
## SECURITY GROUPS
resource "aws_security_group" "bastion" {
  name        = "${var.application}-bastion.${terraform.workspace}.${var.domain}"
  description = "${var.application}-bastion security group"

  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}-bastion.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

resource "aws_security_group_rule" "in-anywhere_22_bastion" {
  type = "ingress"

  protocol = "tcp"

  from_port = "22"
  to_port   = "22"

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.bastion.id
}
