variable "env" {}
variable "project" {}
variable "region" {}

variable "default_tags" {
  type = "map"
}

variable "private_subnet_ids" {
  description = "list of CIDRs for the private subnets"
  default = []
}

variable "ami_id" {
  description = "AMI ID for your App & bastion host | Official public CentOS 7.4 ami-66a7871c OR for marketplace use ami-af4333cf"
  default = "ami-66a7871c"
}

variable "pub_key_path" {
  description = "SSH Public Key path for App"
  default = "id_rsa.pub"
}

variable "userdata" {
  description = "User Data"
  default = "#!/usr/bin/env bash\n\t      yum update -y && yum install httpd -y \n              echo \"Your terraform setup, using most of interpolation & modules. Cheers!!\" > /var/www/html/index.html\n"
}

variable "app_instance_type" {
  description = "EC2 instance type for app host"
  default = "t2.micro"
}

variable "azs" {
  default = []
}

variable "userdata_template_path" {
  description = "User Data TPL path"
  default = "init.tpl"
}

variable "mount_target_dns" {
  default = ""
}

variable "target_group_arns" {
  default = []
}

variable "security_groups" {
  default = []
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  default     = {}
}

