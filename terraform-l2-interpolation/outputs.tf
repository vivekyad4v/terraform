output "alb_dns" {
  description = "The DNS name of the load balancer."
  value       = "${aws_lb.alb.dns_name}"
}

output "vpc_id" {
  value       = "${aws_vpc.myvpc.id}"
}

output "public_subnets_ids" {
   value = ["${data.aws_subnet.public.*.id}"]
}

output "private_subnets_ids" {
   value = ["${data.aws_subnet.private.*.id}"]
}

output "igw_id" {
  value       = "${aws_internet_gateway.igw.id}"
}

output "ngw_id" {
  value       = "${aws_nat_gateway.ngw.id}"
}

output "ngw_eip" {
  value       = "${aws_eip.ngw_eip.public_ip}"
}

