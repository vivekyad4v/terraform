resource "aws_lb" "alb" {
  name = "${var.orgname}-${var.environ}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sg_alb.id}"]
  subnets            = ["${data.aws_subnet.public.*.id}"]
  enable_deletion_protection = false

  tags = "${merge(map("Name", format("%s-%s-alb", var.orgname, var.environ)), var.tags)}"
}

resource "aws_lb_target_group" "alb_tg" {
  port      = "80"
  protocol  = "HTTP"
  vpc_id    = "${aws_vpc.myvpc.id}"
  deregistration_delay = 60
  health_check {
    healthy_threshold   = 2
    interval            = 15
    path                = "/"
    timeout             = 10
    unhealthy_threshold = 2
    matcher             = "200-499"
    }

  tags = "${merge(map("Name", format("%s-%s-alb-tg", var.orgname, var.environ)), var.tags)}"
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
