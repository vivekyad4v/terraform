resource "aws_vpc" "org_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.environ}_${var.orgname}_vpc"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = "${aws_vpc.org_vpc.id}"
  cidr_block = "${var.private_subnet_1_cidr}"
  availability_zone = "${var.aws_region}a"

  tags {
    Name = "${var.environ}_${var.orgname}_pvtsub_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = "${aws_vpc.org_vpc.id}"
  cidr_block = "${var.private_subnet_2_cidr}"
  availability_zone = "${var.aws_region}b"

  tags {
    Name = "${var.environ}_${var.orgname}_pvtsub_2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id = "${aws_vpc.org_vpc.id}"
  cidr_block = "${var.private_subnet_3_cidr}"
  availability_zone = "${var.aws_region}c"

  tags {
    Name = "${var.environ}_${var.orgname}_pvtsub_3"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = "${aws_vpc.org_vpc.id}"
  cidr_block = "${var.public_subnet_1_cidr}"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.environ}_${var.orgname}_pubsub_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = "${aws_vpc.org_vpc.id}"
  cidr_block = "${var.public_subnet_2_cidr}"
  availability_zone = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.environ}_${var.orgname}_pubsub_2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id = "${aws_vpc.org_vpc.id}"
  cidr_block = "${var.public_subnet_3_cidr}"
  availability_zone = "${var.aws_region}c"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.environ}-${var.orgname}-pubsub-3"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.org_vpc.id}"

  tags {
    Name = "${var.environ}_${var.orgname}_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.org_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.environ}_${var.orgname}_public_rt"
  }
}

resource "aws_route_table_association" "public_rt_1" {
  subnet_id = "${aws_subnet.public_subnet_1.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "public_rt_2" {
  subnet_id = "${aws_subnet.public_subnet_2.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "public_rt_3" {
  subnet_id = "${aws_subnet.public_subnet_3.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_eip" "ngw_eip" {
  vpc = true
  tags {
    Name = "${var.environ}_${var.orgname}_ngw_eip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.ngw_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet_1.id}"

  tags {
    Name = "${var.environ}_${var.orgname}_ngw"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.org_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ngw.id}"
  }

  tags {
    Name = "${var.environ}_${var.orgname}_private_rt"
  }
}

resource "aws_route_table_association" "private_rt_1" {
  subnet_id = "${aws_subnet.private_subnet_1.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

resource "aws_route_table_association" "private_rt_2" {
  subnet_id = "${aws_subnet.private_subnet_2.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

resource "aws_route_table_association" "private_rt_3" {
  subnet_id = "${aws_subnet.private_subnet_3.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

