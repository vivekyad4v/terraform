output "id" {
  description = "List of IDs of instances"
  value       = ["${aws_instance.ec2.*.id}"]
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = ["${aws_instance.ec2.*.availability_zone}"]
}

output "key_name" {
  description = "List of key names of instances"
  value       = ["${aws_instance.ec2.*.key_name}"]
}

output "EIP" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${aws_eip.eip.*.public_ip}"]
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${aws_instance.ec2.*.subnet_id}"]
}

#output "vpc_security_group_ids" {
#  description = "List of IDs of VPC subnets of instances"
#  value       = ["${aws_instance.ec2.*.vpc_security_group_ids}"]
#}

