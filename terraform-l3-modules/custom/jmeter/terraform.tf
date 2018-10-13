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
 key = "custom/jmeter/jmeter.tfstate"
  }
}

