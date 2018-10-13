output "id" {
  value = "${element(concat(aws_efs_file_system.this.*.id, list("")), 0)}"
}

output "dns_name" {
  value = "${element(concat(aws_efs_file_system.this.*.dns_name, list("")), 0)}"
}

output "mount_target_ids" {
  value = ["${aws_efs_mount_target.this.*.id}"]
}

output "template_rendered" {
  value       = "${data.template_file.efs-mount.rendered}"
}

output "instance_id" {
  description = "List of IDs of instances"
  value       = ["${module.ec2-instance.id}"]
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = ["${module.ec2-instance.availability_zone}"]
}

output "key_name" {
  description = "List of key names of instances"
  value       = ["${module.ec2-instance.key_name}"]
}

output "EIP" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${module.ec2-instance.EIP}"]
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${module.ec2-instance.subnet_id}"]
}

output "ec2_vpc_security_group_ids" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${module.ec2-instance.vpc_security_group_ids}"]
}



