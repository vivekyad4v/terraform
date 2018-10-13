variable "env" {}
variable "project" {}
variable "region" {}

variable "default_tags" {
  type = "map"
}

variable "name_prefix" {
  description = "The identifier of the resource"
  default = ""
}

variable "create" {
  description = "Whether to create this resource or not?"
  default     = true
}

variable "subnet_ids" {
  type        = "list"
  description = "A list of VPC subnet IDs"
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  default     = {}
}

