output "alb_dns" {
  description = "The DNS name of the load balancer."
  value       = "${aws_lb.alb.dns_name}"
}

output "target_group_id" {
  description = "ID of target group"
  value       = "${aws_lb_target_group.alb_tg.id}"
}

output "alb_listener_id" {
  description = "ID of ALB listener"
  value       = "${aws_lb_listener.alb_lis.id}"
}
