output "vpc_id" {
  value       = "${aws_vpc.myvpc.id}"
}

output "public_subnets_ids" {
   value = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets_ids" {
   value = ["${aws_subnet.private_subnet.*.id}"]
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
