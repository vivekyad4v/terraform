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
    cidr_blocks = ["0.0.0.0/0"]
#    security_groups = ["${aws_security_group.alb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(map("Name", format("%s-%s-ec2", var.project, var.env)), var.default_tags)}"
}

