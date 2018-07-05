variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "orgname" {
  description = "Name of organization - For reference/tag"
  default = "neworg"
}

variable "environ" {
  description = "Environment for VPC like UAT, Staging, Prod - For reference/tag"
  default = "uat"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.16.0.0/16"
}

variable "private_subnet_1_cidr" {
  description = "CIDR for the private subnet"
  default = "172.16.16.0/20"
}

variable "private_subnet_2_cidr" {
  description = "CIDR for the private subnet"
  default = "172.16.64.0/20"
}

variable "private_subnet_3_cidr" {
  description = "CIDR for the private subnet"
  default = "172.16.128.0/20"
}

variable "public_subnet_1_cidr" {
  description = "CIDR for the public subnet"
  default = "172.16.32.0/20"
}

variable "public_subnet_2_cidr" {
  description = "CIDR for the public subnet"
  default = "172.16.96.0/20"
}

variable "public_subnet_3_cidr" {
  description = "CIDR for the public subnet"
  default = "172.16.160.0/20"
}

variable "ami_id" {
  description = "Ubuntu AMI"
  default = "ami-759bc50a"
}

variable "pub_key_path" {
  description = "SSH Public Key path"
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

