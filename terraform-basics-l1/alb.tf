resource "aws_lb" "alb" {
  name               = "${var.environ}-neworg-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sg_alb.id}"]
  subnets            = ["${aws_subnet.public_subnet_1.id}", "${aws_subnet.public_subnet_2.id}", "${aws_subnet.public_subnet_3.id}"]

  enable_deletion_protection = false

  tags {
    Name = "${var.environ}_neworg_alb"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name      = "${var.environ}_neworg_tg"
  port      = "80"
  protocol  = "HTTP"
  vpc_id    = "${aws_vpc.org_vpc.id}"
  deregistration_delay = 60
  health_check {
    healthy_threshold   = 2
    interval            = 15
    path                = "/"
    timeout             = 10
    unhealthy_threshold = 2
    matcher             = "200-499"
    }
  tags {
    Name = "${var.environ}_neworg_tg"
  }
}

resource "aws_lb_listener" "alb_lis" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.alb_tg.arn}"
    type             = "forward"
  }
}

