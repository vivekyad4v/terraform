resource "aws_lb" "alb" {
  name = "${var.project}-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.security_groups}"]
  subnets            = ["${var.subnets}"]
  enable_deletion_protection = false

  tags = "${merge(map("Name", format("%s-%s-alb", var.project, var.env)), var.default_tags)}"
}

resource "aws_lb_target_group" "alb_tg" {
  name = "${var.project}-${var.env}-alb-tg"
  port      = "80"
  protocol  = "HTTP"
  vpc_id    = "${var.vpc_id}"
  deregistration_delay = 60
  health_check {
    healthy_threshold   = 2
    interval            = 15
    path                = "/"
    timeout             = 10
    unhealthy_threshold = 2
    matcher             = "200-499"
    }

  tags = "${merge(map("Name", format("%s-%s-alb-tg", var.project, var.env)), var.default_tags)}"
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
