output "vpc_id" {
	value = "${data.terraform_remote_state.vpc.vpc_id}"
}

output "public_subnets" {
	value = ["${data.terraform_remote_state.vpc.public_subnets_ids}"]
}

output "private subnets" {
	value = ["${data.terraform_remote_state.vpc.private_subnets_ids}"]
}

output "alb_dns" {
	value = "${module.alb.alb_dns}"
}

output "target_group_id" {
	value = "${module.alb.target_group_id}"
}

output "alb_listener_id" {
	value = "${module.alb.alb_listener_id}"
}

output "aws_autoscaling_group_id" {
	value = "${module.asg.aws_autoscaling_group_id}"
}

output "aws_launch_configuration_id" {
	value = "${module.asg.aws_launch_configuration_id}"
}

output "aws_key_pair_name" {
	value = "${module.asg.aws_key_pair_name}"
}

output "userdata_template_rendered" {
	value = "${module.asg.template_rendered}"
}

output "db_instance_address" {
	value = "${module.db_instance.this_db_instance_address}"
}

output "db_instance_arn" {
	value = "${module.db_instance.this_db_instance_arn}"
}

output "db_instance_endpoint" {
	value = "${module.db_instance.this_db_instance_endpoint}"
}

output "db_instance_id" {
	value = "${module.db_instance.this_db_instance_id}"
}

output "db_instance_status" {
	value = "${module.db_instance.this_db_instance_status}"
}

output "db_instance_name" {
	value = "${module.db_instance.this_db_instance_name}"
}

output "db_instance_username" {
	value = "${module.db_instance.this_db_instance_username}"
}

output "db_instance_password" {
	value = "${module.db_instance.this_db_instance_password}"
	  sensitive = true
}

output "db_instance_port" {
	value = "${module.db_instance.this_db_instance_port}"
}

output "db_subnet_group_id" {
	value = "${module.db_subnet_group.this_db_subnet_group_id}"
}

output "db_subnet_group_arn" {
	value = "${module.db_subnet_group.this_db_subnet_group_arn}"
}

output "efs_id" {
	value = "${module.efs.id}"
}

output "efs_mount_target_dns" {
	value = "${module.efs.mount_target_dns}"
}

output "efs_mount_target_ids" {
	value = ["${module.efs.mount_target_ids}"]
}

output "es_arn" {
	value = "${module.es.arn}"
}

output "es_domain_id" {
	value = "${module.es.domain_id}"
}

output "es_endpoint" {
	value = "${module.es.endpoint}"
}

output "aws_security_group_alb_id" {
	value = ["${module.sg.aws_security_group_alb_id}"]
}

output "aws_security_group_ec2_id" {
	value = ["${module.sg.aws_security_group_ec2_id}"]
}

output "aws_security_group_db_id" {
	value = ["${module.sg.aws_security_group_db_id}"]
}

output "aws_security_group_efs_id" {
	value = ["${module.sg.aws_security_group_efs_id}"]
}

output "aws_security_group_es_id" {
	value = ["${module.sg.aws_security_group_es_id}"]
}


