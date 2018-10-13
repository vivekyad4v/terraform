resource "aws_security_group" "this-efs" {

  name        = "${var.orgname}-${var.environ}-efs"
  vpc_id      = "vpc-08a8658441b86bd01"
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = "2049"                     # NFS
    to_port         = "2049"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.this-ec2.*.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s-%s", var.orgname, var.environ)), var.tags)}"
}

resource "aws_security_group" "this-ec2" {

  name        = "${var.orgname}-${var.environ}-ec2"
  vpc_id      = "vpc-08a8658441b86bd01"
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = "22"                     # NFS
    to_port         = "22"
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
#    security_groups = ["${var.security_groups}"]    ## Remote state SGs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s-%s", var.orgname, var.environ)), var.tags)}"
}

