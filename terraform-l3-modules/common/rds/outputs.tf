output "this_db_instance_address" {
  description = "The address of the RDS instance"
  value       = "${module.db_instance.this_db_instance_address}"
}

output "this_db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = "${module.db_instance.this_db_instance_arn}"
}

output "this_db_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${module.db_instance.this_db_instance_endpoint}"
}

output "this_db_instance_id" {
  description = "The RDS instance ID"
  value       = "${module.db_instance.this_db_instance_id}"
}

output "this_db_instance_status" {
  description = "The RDS instance status"
  value       = "${module.db_instance.this_db_instance_status}"
}

output "this_db_instance_name" {
  description = "The database name"
  value       = "${module.db_instance.this_db_instance_name}"
}

output "this_db_instance_username" {
  description = "The master username for the database"
  value       = "${module.db_instance.this_db_instance_username}"
}

output "this_db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = "${var.password}"
}

output "this_db_instance_port" {
  description = "The database port"
  value       = "${module.db_instance.this_db_instance_port}"
}

output "this_db_subnet_group_id" {
  description = "The ARN of the db subnet group"
  value       = "${module.db_subnet_group.this_db_subnet_group_id}"
}

output "this_db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = "${module.db_subnet_group.this_db_subnet_group_arn}"
}

