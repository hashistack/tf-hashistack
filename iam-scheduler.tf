# IAM
## POLICY
data "aws_iam_policy_document" "scheduler" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "scheduler" {
  name = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"

  policy = data.aws_iam_policy_document.scheduler.json
}

## ROLE
resource "aws_iam_role" "scheduler" {
  name = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"

  assume_role_policy = data.aws_iam_policy_document.ec2-assume_role.json

  tags = {
    Name        = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

## POLICY ATTACHMENT
resource "aws_iam_role_policy_attachment" "scheduler" {
  role = aws_iam_role.scheduler.name

  policy_arn = aws_iam_policy.scheduler.arn
}

## INSTANCE PROFILE
resource "aws_iam_instance_profile" "scheduler" {
  name = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"

  role = aws_iam_role.scheduler.name
}
