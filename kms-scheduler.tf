# KMS
## KMS KEY
resource "aws_kms_key" "scheduler" {
  description = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"

  enable_key_rotation = true

  tags = {
    Name        = "${var.application}-scheduler.${terraform.workspace}.${var.domain}"
    Workspace   = terraform.workspace
    Environment = var.env_names[terraform.workspace]
    App         = var.application
    terraformed = true
  }
}

## KMS ALIAS
resource "aws_kms_alias" "scheduler" {
  name = replace("alias/${var.application}-scheduler.${terraform.workspace}.${var.domain}", ".", "-")

  target_key_id = aws_kms_key.scheduler.key_id
}
