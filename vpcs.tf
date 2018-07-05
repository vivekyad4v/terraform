resource "aws_vpc" "neworg" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.environ}-neworg-vpc"
  }
}

resource "aws_subnet" "private-subnet1" {
  vpc_id = "${aws_vpc.neworg.id}"
  cidr_block = "${var.private_subnet1_cidr}"
  availability_zone = "${var.aws_region}a"

  tags {
    Name = "${var.environ}-neworg-pvtsub-1"
  }
}

resource "aws_subnet" "private-subnet2" {
  vpc_id = "${aws_vpc.neworg.id}"
  cidr_block = "${var.private_subnet2_cidr}"
  availability_zone = "${var.aws_region}b"

  tags {
    Name = "${var.environ}-neworg-pvtsub-2"
  }
}

resource "aws_subnet" "private-subnet3" {
  vpc_id = "${aws_vpc.neworg.id}"
  cidr_block = "${var.private_subnet3_cidr}"
  availability_zone = "${var.aws_region}c"

  tags {
    Name = "${var.environ}-neworg-pvtsub-3"
  }
}

resource "aws_subnet" "public-subnet1" {
  vpc_id = "${aws_vpc.neworg.id}"
  cidr_block = "${var.public_subnet1_cidr}"
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.environ}-neworg-pubsub-1"
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id = "${aws_vpc.neworg.id}"
  cidr_block = "${var.public_subnet2_cidr}"
  availability_zone = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.environ}-neworg-pubsub-2"
  }
}

resource "aws_subnet" "public-subnet3" {
  vpc_id = "${aws_vpc.neworg.id}"
  cidr_block = "${var.public_subnet3_cidr}"
  availability_zone = "${var.aws_region}c"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.environ}-neworg-pubsub-3"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.neworg.id}"

  tags {
    Name = "${var.environ}-neworg-igw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.neworg.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.environ}-neworg-public-rt"
  }
}

resource "aws_route_table_association" "public-rt1" {
  subnet_id = "${aws_subnet.public-subnet1.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
  depends_on     = ["aws_route_table.public-rt"]
}

resource "aws_route_table_association" "public-rt2" {
  subnet_id = "${aws_subnet.public-subnet2.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
  depends_on     = ["aws_route_table.public-rt"]
}

resource "aws_route_table_association" "public-rt3" {
  subnet_id = "${aws_subnet.public-subnet3.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
  depends_on     = ["aws_route_table.public-rt"]
}

resource "aws_eip" "ngw-eip" {
  vpc = true
  tags {
    Name = "${var.environ}-neworg-ngw-eip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.ngw-eip.id}"
  subnet_id     = "${aws_subnet.public-subnet1.id}"

  tags {
    Name = "${var.environ}-neworg-ngw"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = "${aws_vpc.neworg.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.ngw.id}"
  }

  tags {
    Name = "${var.environ}-neworg-private-rt"
  }
}

resource "aws_route_table_association" "private-rt1" {
  subnet_id = "${aws_subnet.private-subnet1.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
  depends_on     = ["aws_route_table.private-rt"]
}

resource "aws_route_table_association" "private-rt2" {
  subnet_id = "${aws_subnet.private-subnet2.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
  depends_on     = ["aws_route_table.private-rt"]
}

resource "aws_route_table_association" "private-rt3" {
  subnet_id = "${aws_subnet.private-subnet3.id}"
  route_table_id = "${aws_route_table.private-rt.id}"
  depends_on     = ["aws_route_table.private-rt"]
}

