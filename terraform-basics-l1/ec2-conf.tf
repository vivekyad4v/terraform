resource "aws_key_pair" "ec2_kp" {
  key_name   = "${var.environ}_neworg_kp"
  public_key = "${file("${var.pub_key_path}")}"
}

resource "aws_launch_template" "lc_ec2" {
  name = "${var.environ}_neworg_lc_ec2_v1"
  image_id = "${var.ami_id}"
  instance_type = "${var.app_instance_type}"
  key_name = "${var.environ}_neworg_kp"
  vpc_security_group_ids = ["${aws_security_group.sg_ec2.id}"]
  user_data = "${base64encode(var.userdata)}"
  block_device_mappings {
    device_name = "/dev/xvdv"
    ebs {
      volume_size = 20
    }
  }
  iam_instance_profile {
    name = "${var.environ}_neworg_ec2_profile"
  }
  lifecycle {
    create_before_destroy = true
  }
  tag_specifications {
    resource_type = "instance"
    tags {
      Name = "${var.environ}_neworg_instance"
    }
    resource_type = "volume"
    tags {
      Name = "${var.environ}_neworg_volume"
    }
  }
}

resource "aws_launch_template" "lc_bastion" {
  name = "${var.environ}_neworg_lc_bastion_v1"
  image_id = "${var.ami_id}"
  instance_type = "${var.bastion_instance_type}"
  key_name = "${var.environ}_neworg_kp"
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
    tags {
      Name = "${var.environ}_neworg_bastion"
    }
    resource_type = "volume"
    tags {
      Name = "${var.environ}_neworg_bastion_volume"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
    name  = "${var.environ}_neworg_asg"
    vpc_zone_identifier = ["${aws_subnet.private_subnet_1.id}","${aws_subnet.private_subnet_2.id}", "${aws_subnet.private_subnet_3.id}"]
    min_size  = 0
    desired_capacity  = 0
    max_size  = 0
    target_group_arns = ["${aws_lb_target_group.alb_tg.arn}"]
    default_cooldown= 100
    health_check_grace_period = 100
    termination_policies = ["ClosestToNextInstanceHour", "NewestInstance"]
    health_check_type="ELB"
    launch_template = {
      id = "${aws_launch_template.lc_ec2.id}"
      version = "$Latest"
   }  
    tag {
      key                 = "Name"
      value               = "${var.environ}_neworg_asg"
      propagate_at_launch = true
   }
}

resource "aws_autoscaling_group" "asg_bastion" {
    name  = "${var.environ}_neworg_bastion_asg"
    vpc_zone_identifier = ["${aws_subnet.public_subnet_1.id}","${aws_subnet.public_subnet_2.id}", "${aws_subnet.public_subnet_3.id}"]
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
    tag {
      key                 = "Name"
      value               = "${var.environ}_neworg_bastion_asg"
      propagate_at_launch = true
   }
}
