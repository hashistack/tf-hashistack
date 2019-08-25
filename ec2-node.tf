## AMI
data "aws_ami" "node" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["cluster_node-${terraform.workspace}-*"]
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
resource "aws_key_pair" "node" {
  key_name   = "${var.application}-node.${terraform.workspace}.${var.domain}"
  public_key = var.node-public_key[terraform.workspace]
}

## LAUNCH CONFIGURATION
resource "aws_launch_configuration" "node" {
  name_prefix = "${var.application}-node.${terraform.workspace}.${var.domain}"

  image_id      = data.aws_ami.node.id
  instance_type = var.node-instance_type[terraform.workspace]
  spot_price    = var.node-spot_price[terraform.workspace]

  key_name = aws_key_pair.node.key_name

  security_groups = [aws_security_group.default.id, aws_security_group.node-ec2.id]

  iam_instance_profile = aws_iam_instance_profile.node.name

  user_data_base64 = base64encode(templatefile("${path.module}/template/node-user_data.sh", {}))

  root_block_device {
    delete_on_termination = var.node-root_block_device-delete_on_termination[terraform.workspace]
    volume_type           = var.node-root_block_device-volume_type[terraform.workspace]
    volume_size           = var.node-root_block_device-volume_size[terraform.workspace]
  }

  lifecycle {
    create_before_destroy = true
  }
}

## AUTO SCALING GROUP
resource "aws_autoscaling_group" "node" {
  name = aws_launch_configuration.node.name

  vpc_zone_identifier = aws_subnet.private.*.id
  load_balancers      = [aws_elb.node.name]

  launch_configuration = aws_launch_configuration.node.name

  min_size = 3
  max_size = 3

  tags = [
    {
      key                 = "Name"
      value               = "${var.application}-node.${terraform.workspace}.${var.domain}"
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
      key                 = "consul"
      value               = "node"
      propagate_at_launch = true
    },
    {
      key                 = "vault"
      value               = "node"
      propagate_at_launch = true
    },
    {
      key                 = "nomad"
      value               = "node"
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

  depends_on = [
    aws_autoscaling_group.scheduler
  ]
}

## LOAD BALANCER
resource "aws_elb" "node" {
  name = replace("${var.application}-node.${terraform.workspace}.${var.domain}", ".", "-")

  subnets = aws_subnet.public.*.id

  security_groups = [aws_security_group.default.id, aws_security_group.node-elb.id]

  # TODO: bad, require fabio running on nomad
  listener {
    instance_port     = 9999
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  tags = {
    Name        = "${var.application}-node.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}
