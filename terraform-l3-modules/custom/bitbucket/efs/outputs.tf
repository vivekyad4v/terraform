output "id" {
  value = "${element(concat(aws_efs_file_system.this.*.id, list("")), 0)}"
}

output "mount_target_dns" {
  value = "${element(concat(aws_efs_file_system.this.*.dns_name, list("")), 0)}"
}

output "mount_target_ids" {
  value = ["${aws_efs_mount_target.this.*.id}"]
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = []
}

output "vpc_security_group_ids" {
  description = "List of IDs of VPC subnets of instances"
  value       = []
}



