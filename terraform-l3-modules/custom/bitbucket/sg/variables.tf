variable "env" {}
variable "project" {}
variable "region" {}

variable "default_tags" {
  type = "map"
}

variable "vpc_id" {
  default = ""
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  default     = {}
}

