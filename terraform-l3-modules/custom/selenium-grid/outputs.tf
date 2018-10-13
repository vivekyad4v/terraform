output "hub_id" {
  description = "List of IDs of instances"
  value       = ["${module.ec2-instance.hub_id}"]
}

output "node_id" {
  description = "List of IDs of instances"
  value       = ["${module.ec2-instance.node_id}"]
}

output "key_name" {
  description = "List of key names of instances"
  value       = ["${module.ec2-instance.key_name}"]
}

output "HUB-EIP" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${module.ec2-instance.HUB-EIP}"]
}

output "NODE-EIP" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${module.ec2-instance.NODE-EIP}"]
}

output "hub_subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${module.ec2-instance.hub_subnet_id}"]
}

output "node_subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${module.ec2-instance.node_subnet_id}"]
}

output "hub_vpc_security_group_ids" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${module.sg.aws_security_group_ec2_id}"]
}

output "node_vpc_security_group_ids" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${module.sg.aws_security_group_ec2_id}"]
}

