output "hub_id" {
  description = "List of IDs of instances"
  value       = ["${aws_instance.hub.*.id}"]
}

output "node_id" {
  description = "List of IDs of instances"
  value       = ["${aws_instance.node.*.id}"]
}

output "key_name" {
  description = "List of key names of instances"
  value       = ["${aws_instance.hub.*.key_name}"]
}

output "HUB-EIP" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${aws_eip.heip.*.public_ip}"]
}

output "NODE-EIP" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${aws_eip.neip.*.public_ip}"]
}

output "hub_subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${aws_instance.hub.*.subnet_id}"]
}

output "node_subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${aws_instance.node.*.subnet_id}"]
}

output "hub_vpc_security_group_ids" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${aws_instance.hub.*.vpc_security_group_ids}"]
}

output "node_vpc_security_group_ids" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${aws_instance.node.*.vpc_security_group_ids}"]
}

