resource "aws_security_group" "sg_alb" {
  description = "Allow public traffic to ALB"

  vpc_id      = "${aws_vpc.myvpc.id}"
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

  tags = "${merge(map("Name", format("%s-%s-alb", var.orgname, var.environ)), var.tags)}"
}

resource "aws_security_group" "sg_ec2" {
  description = "Allow traffic to EC2 from ALB"

  vpc_id      = "${aws_vpc.myvpc.id}"
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

  tags = "${merge(map("Name", format("%s-%s-ec2", var.orgname, var.environ)), var.tags)}"
}

resource "aws_security_group" "sg_bastion" {
  description = "Allow public SSH traffic to Bastion host"

  vpc_id      = "${aws_vpc.myvpc.id}"
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

  tags = "${merge(map("Name", format("%s-%s-bastion", var.orgname, var.environ)), var.tags)}"
}

resource "aws_security_group" "sg_db" {
  description = "Allow DB connection only from EC2"

  vpc_id      = "${aws_vpc.myvpc.id}"
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

  tags = "${merge(map("Name", format("%s-%s-db", var.orgname, var.environ)), var.tags)}"
}


resource "aws_security_group" "public" {
  description = "Allow all traffic"
  vpc_id      = "${aws_vpc.myvpc.id}"

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

  tags = "${merge(map("Name", format("%s-%s-all-public", var.orgname, var.environ)), var.tags)}"
}
