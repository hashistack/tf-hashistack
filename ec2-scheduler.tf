## AMI
data "aws_ami" "scheduler" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["cluster_scheduler-${terraform.workspace}-*"]
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
resource "aws_key_pair" "scheduler" {
  key_name   = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"
  public_key = var.scheduler-public_key[terraform.workspace]
}

## LAUNCH CONFIGURATION
resource "aws_launch_configuration" "scheduler" {
  name_prefix = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"

  image_id      = data.aws_ami.scheduler.id
  instance_type = var.scheduler-instance_type[terraform.workspace]
  spot_price    = var.scheduler-spot_price[terraform.workspace]

  key_name = aws_key_pair.scheduler.key_name

  security_groups = [aws_security_group.default.id, aws_security_group.scheduler.id]

  iam_instance_profile = aws_iam_instance_profile.scheduler.name

  user_data_base64 = base64encode(templatefile("${path.module}/template/scheduler-user_data.sh", { bootstrap-expect = length(aws_subnet.public), vault-seal-awskms-kms_key_id = aws_kms_key.scheduler.key_id }))

  root_block_device {
    delete_on_termination = var.scheduler-root_block_device-delete_on_termination[terraform.workspace]
    volume_type           = var.scheduler-root_block_device-volume_type[terraform.workspace]
    volume_size           = var.scheduler-root_block_device-volume_size[terraform.workspace]
  }

  lifecycle {
    create_before_destroy = true
  }
}

## AUTO SCALING GROUP
resource "aws_autoscaling_group" "scheduler" {
  name = aws_launch_configuration.scheduler.name

  vpc_zone_identifier = aws_subnet.private.*.id
  load_balancers      = [aws_elb.scheduler.name]

  launch_configuration = aws_launch_configuration.scheduler.name

  min_size = length(aws_subnet.private)
  max_size = length(aws_subnet.private)

  tags = [
    {
      key                 = "Name"
      value               = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"
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
      value               = "scheduler"
      propagate_at_launch = true
    },
    {
      key                 = "vault"
      value               = "scheduler"
      propagate_at_launch = true
    },
    {
      key                 = "nomad"
      value               = "scheduler"
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

## LOAD BALANCER
resource "aws_elb" "scheduler" {
  name = replace("${var.application}-sch.${terraform.workspace}.${var.domain}", ".", "-") # TODO: change naming strategy (> 32 chars)

  subnets = aws_subnet.public.*.id

  security_groups = [aws_security_group.default.id, aws_security_group.scheduler-elb.id]

  listener {
    instance_port      = 4646
    instance_protocol  = "http"
    lb_port            = 4646
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.scheduler.arn
  }

  listener {
    instance_port      = 8200
    instance_protocol  = "http"
    lb_port            = 8200
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.scheduler.arn
  }

  tags = {
    Name        = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}
