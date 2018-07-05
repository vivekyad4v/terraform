resource "aws_security_group" "sg-alb" {
  name        = "${var.environ}-neworg-alb"
  description = "Allow ELB ports"
  vpc_id      = "${aws_vpc.neworg.id}"
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
    Name = "${var.environ}-neworg-alb"
  }
}

resource "aws_security_group" "sg-ec2" {
  name        = "${var.environ}-neworg-ec2"
  description = "${var.environ}-neworg-ec2"
  vpc_id      = "${aws_vpc.neworg.id}"
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
    security_groups = ["${aws_security_group.sg-alb.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.environ}-neworg-ec2"
  }
}

resource "aws_security_group" "sg-bastion" {
  name        = "${var.environ}-neworg-bastion"
  description = "${var.environ}-neworg-bastion"
  vpc_id      = "${aws_vpc.neworg.id}"
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
    Name = "${var.environ}-neworg-bastion"
  }
}

resource "aws_security_group" "sg-db" {
  name        = "${var.environ}-neworg-db"
  description = "Allow DB ports inbound from EC2"
  vpc_id      = "${aws_vpc.neworg.id}"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = ["${aws_security_group.sg-ec2.id}"]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = ["${aws_security_group.sg-ec2.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.environ}-neworg-db"
  }
}


resource "aws_security_group" "public" {
  name        = "public"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.neworg.id}"
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

