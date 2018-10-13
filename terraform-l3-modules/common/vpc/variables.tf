variable "orgname" {
  description = "Name of organization or project"
  default = "neworg"
}

variable "environ" {
  description = "AMI ID for your App & bastion host"
  default = "uat"
}

variable "azs" {
  description = "AMI ID for your App & bastion host"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.16.0.0/16"
}

variable "private_subnets" {
  description = "list of CIDRs for the private subnets"
  default = ["172.16.16.0/20", "172.16.32.0/20", "172.16.64.0/20"]
}

variable "public_subnets" {
  description = "list of CIDRs for the public subnets"
  default = ["172.16.96.0/20", "172.16.128.0/20", "172.16.160.0/20"]
}

variable "tags" {
  description = "AMI ID for your App & bastion host"
  default = {
    ID          = "demo"
    Creator       = "vivek"
    Environment   = "uat"
  }
}
