resource "aws_vpc" "myvpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = "${merge(map("Name", format("%s-%s-vpcs", var.orgname, var.environ)), var.tags)}"
}

resource "aws_subnet" "private_subnet" {
  count = "${length(var.private_subnets)}"

  vpc_id            = "${aws_vpc.myvpc.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = "${merge(map("Name", format("%s-%s-pvtt-%s", var.orgname, var.environ, element(var.azs, count.index))), var.tags)}"
}

resource "aws_subnet" "public_subnet" {
  count = "${length(var.public_subnets)}"

  vpc_id            = "${aws_vpc.myvpc.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = "true"

  tags = "${merge(map("Name", format("%s-%s-pub-%s", var.orgname, var.environ, element(var.azs, count.index))), var.tags)}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = "${merge(map("Name", format("%s-%s-vpc-igw", var.orgname, var.environ)), var.tags)}"
}

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = "${merge(map("Name", format("%s-%s-pub-rt", var.orgname, var.environ)), var.tags)}"
}

resource "aws_eip" "ngw_eip" {
  vpc = true

  tags = "${merge(map("Name", format("%s-%s-ngw-eip", var.orgname, var.environ)), var.tags)}"
}

resource "aws_nat_gateway" "ngw" {
  count = 1 

  allocation_id = "${aws_eip.ngw_eip.id}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, count.index)}"

  tags = "${merge(map("Name", format("%s-%s-ngw", var.orgname, var.environ)), var.tags)}"
}

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.myvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ngw.id}"
  }

  tags = "${merge(map("Name", format("%s-%s-pvt-rt", var.orgname, var.environ)), var.tags)}"
}

resource "aws_route_table_association" "public_rta" {
  count = "${length(var.public_subnets)}"
  subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "private_rta" {
  count = "${length(var.public_subnets)}"
  subnet_id = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private_rt.id}"
}
