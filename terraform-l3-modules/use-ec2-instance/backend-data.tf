provider "aws" {
  version = "~> 1.25"
#  access_key = "${var.aws_access_key}"
#  secret_key = "${var.aws_secret_key}"
#  region     = "us-east-1"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "${var.s3_bucket_name}"
    key    = "${var.vpc_key}"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "ec2_instance" {
  backend = "s3"
  config {
    bucket = "${var.s3_bucket_name}"
    key    = "${var.ec2_instance_key}"
    region = "us-east-1"
  }
}

