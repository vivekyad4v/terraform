resource "aws_lb" "alb" {
  name               = "${var.environ}-neworg-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sg-alb.id}"]
  subnets            = ["${aws_subnet.public-subnet1.id}", "${aws_subnet.public-subnet2.id}", "${aws_subnet.public-subnet3.id}"]

  enable_deletion_protection = false

  tags {
    Name = "${var.environ}-neworg-alb"
  }
}

resource "aws_lb_target_group" "alb-tg" {
  name      = "${var.environ}-neworg-tg"
  port      = "80"
  protocol  = "HTTP"
  vpc_id    = "${aws_vpc.neworg.id}"
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
    Name = "${var.environ}-neworg-tg"
  }
}

resource "aws_lb_listener" "alb-lis" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.alb-tg.arn}"
    type             = "forward"
  }
}

