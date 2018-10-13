variable "orgname" {
  description = "Name of organization or project"
  default = "neworg"
}

variable "environ" {
  description = "Environment identity"
  default = "uat"
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  default     = "ami-759bc50a"
}

variable "instance_count" {
  description = "ID of AMI to use for the instance, supports 1 for now"
  default     = "1"
}

variable "instance_type" {
  description = "The type of instance to start"
    default     = "t2.micro"
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = "vk-kp"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default = "subnet-06b228d2385fc94b0"
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = "false"
}

variable "associate_eip" {
  default = "true"
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""
}

variable "root_device_size" {
  description = "Customize details about the root block device of the instance"
  default     = "12"
}

variable "tags" {
  description = "AMI ID for your App & bastion host"
  default = {
    ID          = "demo"
    Creator       = "vivek"
    Environment   = "uat"
  }
}

variable "user_data_template_path" {
  description = "Customize details about the root block device of the instance"
  default     = "apache.tpl"
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = "list"
  default = []
}

#variable "iam_instance_profile" {
#  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
#  default     = ""
#}

#variable "instance_count" {
#  description = "ID of AMI to use for the instance"
#  default     = "1"
#}

