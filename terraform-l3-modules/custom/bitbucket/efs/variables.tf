variable "env" {}
variable "project" {}
variable "region" {}

variable "default_tags" {
  type = "map"
}

variable "security_groups" {
  default = []
}

variable "subnets" {
  default = []
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  default     = {}
}

