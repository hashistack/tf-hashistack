# VPC
## SECURITY GROUP ELB
resource "aws_security_group" "node-elb" {
  name        = "${var.application}-node-elb.${terraform.workspace}.${var.domain}"
  description = "${var.application}-node-elb security group"

  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}-node-elb.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

resource "aws_security_group_rule" "in-anywhere_80_node-elb" {
  type = "ingress"

  protocol = "tcp"

  from_port = "80"
  to_port   = "80"

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.node-elb.id
}

## SECURITY GROUP EC2
resource "aws_security_group" "node-ec2" {
  name        = "${var.application}-node-ec2.${terraform.workspace}.${var.domain}"
  description = "${var.application}-node-ec2 security group"

  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application}-node-ec2.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}
