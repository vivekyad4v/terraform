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

resource "aws_launch_template" "lc_ec2" {
  name = "${var.orgname}-${var.environ}-lc-ec2"
  image_id = "${var.ami_id}"
  instance_type = "${var.app_instance_type}"
  key_name = "${var.orgname}_${var.environ}_kp"
  vpc_security_group_ids = ["${aws_security_group.sg_ec2.id}"]
  user_data = "${base64encode(var.userdata)}"
  block_device_mappings {
    device_name = "/dev/xvdv"
    ebs {
      volume_size = 15
    }
  }
  iam_instance_profile {
    name = "${var.orgname}_${var.environ}_profile"
  }
  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = "${merge(map("Name", format("%s-%s-lc-ec2", var.orgname, var.environ)), var.tags)}"
    } 
  tag_specifications {
    resource_type = "volume"
   tags = "${merge(map("Name", format("%s-%s-lc-ec2-volume", var.orgname, var.environ)), var.tags)}"
    }
  tags = "${merge(map("Name", format("%s-%s-lc-ec2", var.orgname, var.environ)), var.tags)}"
}


resource "aws_launch_template" "lc_bastion" {
  name = "${var.orgname}-${var.environ}-lc-bastion"
  image_id = "${var.ami_id}"
  instance_type = "${var.bastion_instance_type}"
  key_name = "${var.orgname}_${var.environ}_kp"
  vpc_security_group_ids = ["${aws_security_group.sg_bastion.id}"]
  block_device_mappings {
    device_name = "/dev/xvdw"
    ebs {
      volume_size = 8
    }
  }
  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = "${merge(map("Name", format("%s-%s-lc-bastion", var.orgname, var.environ)), var.tags)}"
    }
  tag_specifications {
    resource_type = "volume"
   tags = "${merge(map("Name", format("%s-%s-lc-bastion-volume", var.orgname, var.environ)), var.tags)}"
    }
  tags = "${merge(map("Name", format("%s-%s-lc-bastion", var.orgname, var.environ)), var.tags)}"
}

resource "aws_autoscaling_group" "asg_ec2" {
    name = "${var.orgname}-${var.environ}-asg-ec2"

    vpc_zone_identifier = ["${data.aws_subnet.private.*.id}"]
    min_size  = 1
    desired_capacity  = 1
    max_size  = 1
    target_group_arns = ["${aws_lb_target_group.alb_tg.arn}"]
    default_cooldown= 100
    health_check_grace_period = 100
    termination_policies = ["ClosestToNextInstanceHour", "NewestInstance"]
    health_check_type="ELB"
    launch_template = {
      id = "${aws_launch_template.lc_ec2.id}"
      version = "$Latest"
   }  

  tags = [
    {
      key                 = "Name"
      value               = "${var.orgname}"
      propagate_at_launch = true
    },
    {
      key                 = "Environ"
      value               = "${var.environ}"
      propagate_at_launch = true
    }
  ]
}

resource "aws_autoscaling_group" "asg_bastion" {
    name = "${var.orgname}-${var.environ}-asg-bastion"

    vpc_zone_identifier = ["${data.aws_subnet.public.*.id}"]
    min_size  = 1
    desired_capacity  = 1
    max_size  = 1
    default_cooldown= 180
    health_check_grace_period = 180
    termination_policies = ["ClosestToNextInstanceHour", "NewestInstance"]
    health_check_type="EC2"
    launch_template = {
      id = "${aws_launch_template.lc_bastion.id}"
      version = "$Latest"
   }

  tags = [
    {
      key                 = "Name"
      value               = "${var.orgname}"
      propagate_at_launch = true
    },
    {
      key                 = "Environ"
      value               = "${var.environ}"
      propagate_at_launch = true
    }
  ]
}
