# Configure the AWS Provider
provider "aws" {
  version = "~> 1.25"
#  access_key = "${var.aws_access_key}"
#  secret_key = "${var.aws_secret_key}"
#  region     = "us-east-1"
}

terraform {
 backend "s3" {
 encrypt = "true"
 bucket = "vk-tf"
 region = "us-east-1"
 key = "custom/bitbucket/bitbucket.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "${var.s3_bucket_name}"
    key    = "${var.vpc_key}"
    region = "us-east-1"
  }
}

## TFSTATE CONFIG

variable "s3_bucket_name" {
  default = "vk-tf"
}

#variable "environ" {
#  default = "uat"
#}

variable "vpc_key" {
  default     = "common/vpc/vpc.tfstate"
}
