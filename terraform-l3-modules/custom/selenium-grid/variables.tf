variable "env" {
   default = "uat"
}

variable "project" {
   default = "selenium-grid"
}

variable "region" {
   default = "us-east-1"
}

variable "default_tags" {
  default = {
    Named = "default"
    Envim = "default"
  }
}

variable "vpc_id" {
  default = ""
}

variable "ami" {
  default = "ami-76ef8f09"
}

variable "instance_type" {
  description = "The type of instance to start"
    default     = "t2.micro"
}

variable "hub_subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default = "subnet-06b228d2385fc94b0"
}

variable "node_subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default = "subnet-06b228d2385fc94b0"
}

variable "root_device_size" {
  description = "Customize details about the root block device of the instance"
  default     = "12"
}



