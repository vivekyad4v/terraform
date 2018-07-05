output "dns_name" {
  description = "The DNS name of the load balancer."
  value       = "${aws_lb.alb.dns_name}"
}

