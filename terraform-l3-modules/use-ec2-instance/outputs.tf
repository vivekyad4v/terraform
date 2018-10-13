output "id" {
  description = "List of IDs of instances"
  value       = ["${module.ec2instance.id}"]
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = ["${module.ec2instance.availability_zone}"]
}

output "key_name" {
  description = "List of key names of instances"
  value       = ["${module.ec2instance.key_name}"]
}

output "EIP" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${module.ec2instance.EIP}"]
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${module.ec2instance.subnet_id}"]
}

