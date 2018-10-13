resource "aws_security_group" "alb" {

  name        = "${var.project}-${var.env}-alb"
  vpc_id      = "${var.vpc_id}"
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = "80"
    to_port         = "80"
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = "443"
    to_port         = "443"
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s-%s-alb", var.project, var.env)), var.default_tags)}"
}


resource "aws_security_group" "ec2" {

  name        = "${var.project}-${var.env}-ec2"
  vpc_id      = "${var.vpc_id}"
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = "22"                     
    to_port         = "22"
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
#    security_groups = ["${var.security_groups}"]       ## Allow this once you have a bastion host
  }

  ingress {
    from_port       = "80"                     
    to_port         = "80"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s-%s-ec2", var.project, var.env)), var.default_tags)}"
}

resource "aws_security_group" "db" {

  name        = "${var.project}-${var.env}-db"
  vpc_id      = "${var.vpc_id}"
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = "5432"
    to_port         = "5432"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ec2.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s-%s-db", var.project, var.env)), var.default_tags)}"
}


resource "aws_security_group" "efs" {

  name        = "${var.project}-${var.env}-efs"
  vpc_id      = "${var.vpc_id}"
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = "2049"                    
    to_port         = "2049"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ec2.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s-%s-efs", var.project, var.env)), var.default_tags)}"
}

resource "aws_security_group" "es" {

  name        = "${var.project}-${var.env}-es"
  vpc_id      = "${var.vpc_id}"
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = "443"
    to_port         = "443"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ec2.id}"]
 }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s-%s-es", var.project, var.env)), var.default_tags)}"
}


