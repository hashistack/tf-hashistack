# EC2
## AMI
data "aws_ami" "bastion" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

## KEY PAIR
resource "aws_key_pair" "bastion" {
  key_name   = "${var.application}-bastion.${terraform.workspace}.${var.domain}"
  public_key = var.bastion-public_key[terraform.workspace]
}

## LAUNCH CONFIGURATION
resource "aws_launch_configuration" "bastion" {
  name_prefix = "${var.application}-bastion.${terraform.workspace}.${var.domain}"

  image_id      = data.aws_ami.bastion.id
  instance_type = var.bastion-instance_type[terraform.workspace]
  spot_price    = var.bastion-spot_price[terraform.workspace]

  key_name = aws_key_pair.bastion.key_name

  security_groups = [aws_security_group.default.id, aws_security_group.bastion.id]

  root_block_device {
    delete_on_termination = var.bastion-root_block_device-delete_on_termination[terraform.workspace]
    volume_type           = var.bastion-root_block_device-volume_type[terraform.workspace]
    volume_size           = var.bastion-root_block_device-volume_size[terraform.workspace]
  }

  lifecycle {
    create_before_destroy = true
  }
}

## AUTO SCALING GROUP
resource "aws_autoscaling_group" "bastion" {
  name = aws_launch_configuration.bastion.name

  vpc_zone_identifier = aws_subnet.public.*.id

  launch_configuration = aws_launch_configuration.bastion.name

  min_size = 1
  max_size = 1

  tags = [
    {
      key                 = "Name"
      value               = "${var.application}-bastion.${terraform.workspace}.${var.domain}"
      propagate_at_launch = true
    },
    {
      key                 = "Workspace"
      value               = terraform.workspace
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = var.env_names[terraform.workspace]
      propagate_at_launch = true
    },
    {
      key                 = "App"
      value               = var.application
      propagate_at_launch = true
    },
    {
      key                 = "bastion"
      value               = true
      propagate_at_launch = true
    },
    {
      key                 = "terraformed"
      value               = true
      propagate_at_launch = true
    },
  ]

  lifecycle {
    create_before_destroy = true
  }
}
