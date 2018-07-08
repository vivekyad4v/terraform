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

variable "ami_id" {
  description = "AMI ID for your App & bastion host"
  default = "ami-759bc50a"
}

variable "pub_key_path" {
  description = "SSH Public Key path for App & Bastion host"
  default = "id_rsa.pub"
}

variable "userdata" {
  description = "User Data"
  default = "#!/usr/bin/env bash\n\t      apt-get update -y && apt-get install apache2 -y \n              echo \"Your first terraform setup\" > /var/www/html/index.html\n"
}

variable "bastion_instance_type" {
  description = "EC2 instance type for bastion host"
  default = "t2.micro"
}

variable "app_instance_type" {
  description = "EC2 instance type for app host"
  default = "t2.micro"
}

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
  default = []
}

variable "tags" {
  description = "AMI ID for your App & bastion host"
  default = {}
}

