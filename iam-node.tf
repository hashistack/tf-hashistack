# IAM
## POLICY
data "aws_iam_policy_document" "node" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "node" {
  name = "${var.application}-node.${terraform.workspace}.${var.domain}"

  policy = data.aws_iam_policy_document.node.json
}

## ROLE
resource "aws_iam_role" "node" {
  name = "${var.application}-node.${terraform.workspace}.${var.domain}"

  assume_role_policy = data.aws_iam_policy_document.ec2-assume_role.json

  tags = {
    Name        = "${var.application}-node.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

## POLICY ATTACHMENT
resource "aws_iam_role_policy_attachment" "node" {
  role = aws_iam_role.node.name

  policy_arn = aws_iam_policy.node.arn
}

## INSTANCE PROFILE
resource "aws_iam_instance_profile" "node" {
  name = "${var.application}-node.${terraform.workspace}.${var.domain}"

  role = aws_iam_role.node.name
}
