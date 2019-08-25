terraform {
  required_version = "~> 0.12.0"

  backend "s3" {
    key = "hashistack/hashistack"

    bucket         = "veberarnaud-terraform-states"
    dynamodb_table = "veberarnaud-terraform-locks"
  }
}

provider "aws" {
  version = "~> 2.17.0"
}
