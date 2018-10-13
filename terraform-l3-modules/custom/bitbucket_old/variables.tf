variable "orgname" {
  description = "The identifier of the resource"
  default = "neworg"
}

variable "environ" {
  description = "The identifier of the resource"
  default = "uat"
}

variable "tags" {
  default = {
    ID          = "demo"
    Creator       = "vivek"
    Environment   = "uat"
  }
}

variable "vpc_id" {
  description = "VPC ID"
  default = ""
}

variable "alb_subnets" {
  default = []
}

variable "alb_security_groups" {
  default = []
}

variable "private_subnet_ids" {
  description = "list of CIDRs for the private subnets"
  default = []
}

variable "mount_target_dns" {
  description = "EFS file system DNS"
  default = ""
}

variable "target_group_arns" {
  description = "Target group ARN for ALB"
  default = []
}

variable "vpc_security_group_ids" {
  default     = []
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  default     = ""
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
  default     = "neworg"
}

variable "username" {
  description = "Username for the master DB user"
  default = "nowuser"
}

variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  default = "nowpassword123QW!#"
}

variable "db_identifier" {
  description = "The identifier of the resource"
  default = "neworg-uat"
}

variable "db_subnet_name_prefix" {
  description = "The identifier of the resource"
  default = "neworg-uat"
}

variable "db_subnet_ids" {
  type        = "list"
  description = "A list of VPC subnet IDs"
  default     = []
}

variable "efs_security_groups" {
  default = []
}

variable "efs_subnets" {
  default = []
}

variable "asg_security_groups" {
  default = []
}

variable "vpc_options" {
  description = "A map of supported vpc options"
  type        = "map"
  default     =  {
#    security_group_ids = []
#    subnet_ids         = []
  }
}





