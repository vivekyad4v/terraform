resource "aws_security_group" "sg_alb" {
  name        = "${var.environ}_${var.orgname}_alb"
  description = "Allow ELB ports"
  vpc_id      = "${aws_vpc.org_vpc.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.environ}_${var.orgname}_alb"
  }
}

resource "aws_security_group" "sg_ec2" {
  name        = "${var.environ}_${var.orgname}_ec2"
  description = "${var.environ}_${var.orgname}_ec2"
  vpc_id      = "${aws_vpc.org_vpc.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.sg_alb.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.environ}_${var.orgname}_ec2"
  }
}

resource "aws_security_group" "sg_bastion" {
  name        = "${var.environ}_${var.orgname}_bastion"
  description = "${var.environ}_${var.orgname}_bastion"
  vpc_id      = "${aws_vpc.org_vpc.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.environ}_${var.orgname}_bastion"
  }
}

resource "aws_security_group" "sg_db" {
  name        = "${var.environ}_${var.orgname}_db"
  description = "Allow DB ports inbound from EC2"
  vpc_id      = "${aws_vpc.org_vpc.id}"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = ["${aws_security_group.sg_ec2.id}"]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = ["${aws_security_group.sg_ec2.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.environ}_${var.orgname}_db"
  }
}


resource "aws_security_group" "public" {
  name        = "public"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.org_vpc.id}"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "public"
  }
  lifecycle {
    ignore_changes = ["name"]
  }
}
