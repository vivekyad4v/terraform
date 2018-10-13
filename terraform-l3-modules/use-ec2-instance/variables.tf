## TFSTATE CONFIG

variable "s3_bucket_name" {
  default = "vk-tf"
}

variable "environ" {
  default = "uat"
}

variable "vpc_key" {
  default     = "common/vpc/vpc.tfstate"
}

variable "ec2_instance_key" {
  default     = "common/ec2_instance/ec2_instance.tfstate"
}

