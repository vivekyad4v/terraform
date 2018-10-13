output "aws_security_group_alb_id" {
  value       = "${aws_security_group.alb.id}"
}

output "aws_security_group_ec2_id" {
  value       = "${aws_security_group.ec2.id}"
}

output "aws_security_group_db_id" {
  value       = "${aws_security_group.db.id}"
}

output "aws_security_group_efs_id" {
  value       = "${aws_security_group.efs.id}"
}

output "aws_security_group_es_id" {
  value       = "${aws_security_group.es.id}"
}

