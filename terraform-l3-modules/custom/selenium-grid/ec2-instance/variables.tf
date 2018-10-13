variable "env" {}

variable "project" {}

variable "region" {}

variable "default_tags" { type = "map" }

variable "ami" {}

variable "instance_type" {
  description = "The type of instance to start"
    default     = "t2.micro"
}

variable "hub_subnet_id" {}
variable "node_subnet_id" {}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = "false"
}

variable "associate_eip" {
  default = "true"
}

variable "pub_key_path" {
  description = "SSH Public Key path for App"
  default = "id_rsa.pub"
}

variable "root_device_size" {
  description = "Customize details about the root block device of the instance"
  default     = "12"
}

variable "security_groups" {
  default = [""]
}

variable "tags" {
   default = {}
}

