resource "aws_security_group" "this-es" {

  name        = "${var.orgname}-${var.environ}-es"
  vpc_id      = "vpc-08a8658441b86bd01"
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = "443"                     # ES
    to_port         = "443"
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
#    security_groups = ["${aws_security_group.this-ec2.*.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s-%s", var.orgname, var.environ)), var.tags)}"
}

