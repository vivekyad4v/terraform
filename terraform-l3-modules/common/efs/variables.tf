variable "orgname" {
  description = "The identifier of the resource"
  default = "neworg"
}

variable "environ" {
  description = "The identifier of the resource"
  default = "uat"
}

variable "tags" {
  description = "AMI ID for your App & bastion host"
  default = {
    ID          = "demo"
    Creator       = "vivek"
    Environment   = "uat"
  }
}

variable "security_groups" {
  type = "list"
  default = []
}

variable "vpc_id" {
  default = "vpc-08a8658441b86bd01"
}

variable "subnets" {
  type = "list"
  default = ["subnet-0d0d862bb8fc1104f", "subnet-08a2f3dd0c14f2913", "subnet-0d9ebbcb7cc163eb4"]
}

variable "aws_region" {
  default     = "us-east-1"
}

variable "efs_dns_name" {
  default     = ""
}
