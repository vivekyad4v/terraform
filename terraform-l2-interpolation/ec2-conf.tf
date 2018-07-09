data "null_data_source" "tags" {
  count = "${length(keys(var.tags))}"

  inputs = {
    key                 = "${element(keys(var.tags), count.index)}"
    value               = "${element(values(var.tags), count.index)}"
    propagate_at_launch = true
  }
}

data "aws_subnet" "public" {
  count = "${length(var.azs)}"

  vpc_id = "${aws_vpc.myvpc.id}"

  tags {
    Name = "${var.orgname}-${var.environ}-pub-${element(var.azs, count.index)}"
  }
  depends_on = ["aws_subnet.public_subnet"]
}

data "aws_subnet" "private" {
  count = "${length(var.azs)}"

  vpc_id = "${aws_vpc.myvpc.id}"

  tags {
    Name = "${var.orgname}-${var.environ}-pvt-${element(var.azs, count.index)}"
  }
  depends_on = ["aws_subnet.private_subnet"]
}

resource "aws_key_pair" "ec2_kp" {
  key_name   = "${var.orgname}_${var.environ}_kp"
  public_key = "${file("${var.pub_key_path}")}"
}

resource "aws_launch_configuration" "lc_ec2" {
#  name = "${var.orgname}-${var.environ}-lc-ec2"
  name_prefix = "${var.orgname}-${var.environ}-lc-ec2"
  image_id = "${var.ami_id}"
  instance_type = "${var.app_instance_type}"
  key_name = "${var.orgname}_${var.environ}_kp"
  security_groups = ["${aws_security_group.sg_ec2.id}"]
  user_data_base64 = "${base64encode(var.userdata)}"
  root_block_device {
    volume_size = 15
    delete_on_termination = true
  }
  iam_instance_profile = "${var.orgname}_${var.environ}_role"
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_launch_configuration" "lc_bastion" {
#  name = "${var.orgname}-${var.environ}-lc-bastion"
  name_prefix = "${var.orgname}-${var.environ}-lc-bastion"
  image_id = "${var.ami_id}"
  instance_type = "${var.bastion_instance_type}"
  key_name = "${var.orgname}_${var.environ}_kp"
  security_groups = ["${aws_security_group.sg_bastion.id}"]
  root_block_device {
    volume_size = 10
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_ec2" {
    name = "${var.orgname}-${var.environ}-asg-ec2-${aws_launch_configuration.lc_ec2.name}"

    vpc_zone_identifier = ["${data.aws_subnet.private.*.id}"]
    min_size  = 1
    desired_capacity  = 1
    max_size  = 1
    target_group_arns = ["${aws_lb_target_group.alb_tg.arn}"]
    default_cooldown= 100
    health_check_grace_period = 100
    termination_policies = ["ClosestToNextInstanceHour", "NewestInstance"]
    health_check_type="ELB"
    depends_on = ["aws_launch_configuration.lc_ec2"]
    launch_configuration = "${aws_launch_configuration.lc_ec2.name}"
    lifecycle {
    create_before_destroy = true
    }

    tags = ["${data.null_data_source.tags.*.outputs}"]
    tags = [
      {
      key                 = "Name"
      value               = "${var.orgname}-${var.environ}-asg-ec2"
      propagate_at_launch = true
       }
     ]
}

resource "aws_autoscaling_group" "asg_bastion" {
    name = "${var.orgname}-${var.environ}-asg-bastion-${aws_launch_configuration.lc_bastion.name}"

    vpc_zone_identifier = ["${data.aws_subnet.public.*.id}"]
    min_size  = 1
    desired_capacity  = 1
    max_size  = 1
    default_cooldown= 180
    health_check_grace_period = 180
    termination_policies = ["ClosestToNextInstanceHour", "NewestInstance"]
    health_check_type="EC2"
    depends_on = ["aws_launch_configuration.lc_bastion"]
    launch_configuration = "${aws_launch_configuration.lc_bastion.name}"
    lifecycle {
    create_before_destroy = true
    }

    tags = [
      {
      key                 = "Name"
      value               = "${var.orgname}-${var.environ}-asg-bastion"
      propagate_at_launch = true
      }
   ]
}



