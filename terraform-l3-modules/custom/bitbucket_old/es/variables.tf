variable "orgname" {
  description = "The identifier of the resource"
  default = "neworg"
}

variable "environ" {
  description = "The identifier of the resource"
  default = "uat"
}

variable "tags" {
  description = "AMI ID for your App & bastion host"
  default = {
    ID          = "demo"
    Creator       = "vivek"
    Environment   = "uat"
  }
}

variable "es_version" {
  description = "Version of Elasticsearch to deploy (default 5.1)"
  default     = "6.0"
}

variable "management_iam_roles" {
  description = "List of IAM role ARNs from which to permit management traffic (default ['*']).  Note that a client must match both the IP address and the IAM role patterns in order to be permitted access."
  type        = "list"
  default     = ["*"]
}

variable "instance_type" {
  description = "ES instance type for data nodes in the cluster (default t2.small.elasticsearch)"
  default     = "t2.small.elasticsearch"
}

variable "instance_count" {
  description = "Number of data nodes in the cluster (default 6)"
  default     = 2
}

variable "dedicated_master_type" {
  description = "ES instance type to be used for dedicated masters (default same as instance_type)"
  default     = false
}

variable "es_zone_awareness" {
  description = "Enable zone awareness for Elasticsearch cluster (default false)"
  default     = "true"
}

variable "ebs_volume_size" {
  description = "Optionally use EBS volumes for data storage by specifying volume size in GB (default 0)"
  default     = 10
}

variable "vpc_options" {
  description = "A map of supported vpc options"
  default     =  {
    security_group_ids = ["a"]
    subnet_ids         = ["b"]
  }
}
