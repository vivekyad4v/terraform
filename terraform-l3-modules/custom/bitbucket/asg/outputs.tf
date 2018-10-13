output "aws_autoscaling_group_id" {
  value       = ["${aws_autoscaling_group.asg_ec2.*.id}"]
}

output "aws_launch_configuration_id" {
  value       = ["${aws_launch_configuration.lc_ec2.*.id}"]
}

output "aws_key_pair_name" {
  value       = ["${aws_key_pair.ec2_kp.*.key_name}"]
}

output "template_rendered" {
  value       = "${data.template_file.init.rendered}"
}

