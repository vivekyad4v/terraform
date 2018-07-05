resource "aws_key_pair" "ec2-kp" {
  key_name   = "${var.environ}-neworg-kp"
  public_key = "${file("${var.pub_key_path}")}"
}

resource "aws_launch_template" "lc-ec2" {
  name = "${var.environ}-neworg-lc-ec2-v1"
  image_id = "${var.ami-id}"
  instance_type = "t2.micro"
  key_name = "${var.environ}-neworg-kp"
  vpc_security_group_ids = ["${aws_security_group.sg-ec2.id}"]
  user_data = "${base64encode(var.userdata)}"
  block_device_mappings {
    device_name = "/dev/xvdv"
    ebs {
      volume_size = 20
    }
  }
  iam_instance_profile {
    name = "${var.environ}-neworg-ec2-profile"
  }
  lifecycle {
    create_before_destroy = true
  }
  tag_specifications {
    resource_type = "instance"
    tags {
      Name = "${var.environ}-neworg-instance"
    }
    resource_type = "volume"
    tags {
      Name = "${var.environ}-neworg-volume"
    }
  }
}

resource "aws_launch_template" "lc-bastion" {
  name = "${var.environ}-neworg-lc-bastion-v1"
  image_id = "${var.ami-id}"
  instance_type = "t2.micro"
  key_name = "${var.environ}-neworg-kp"
  vpc_security_group_ids = ["${aws_security_group.sg-bastion.id}"]
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
      Name = "${var.environ}-neworg-bastion"
    }
    resource_type = "volume"
    tags {
      Name = "${var.environ}-neworg-bastion-volume"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
    name  = "${var.environ}-neworg-asg"
    vpc_zone_identifier = ["${aws_subnet.private-subnet1.id}","${aws_subnet.private-subnet2.id}", "${aws_subnet.private-subnet3.id}"]
    min_size  = 0
    desired_capacity  = 0
    max_size  = 0
    target_group_arns = ["${aws_lb_target_group.alb-tg.arn}"]
    default_cooldown= 100
    health_check_grace_period = 100
    termination_policies = ["ClosestToNextInstanceHour", "NewestInstance"]
    health_check_type="ELB"
    launch_template = {
      id = "${aws_launch_template.lc-ec2.id}"
      version = "$Latest"
   }  
    tag {
      key                 = "Name"
      value               = "${var.environ}-neworg-asg"
      propagate_at_launch = true
   }
}

resource "aws_autoscaling_group" "asg-bastion" {
    name  = "${var.environ}-neworg-bastion-asg"
    vpc_zone_identifier = ["${aws_subnet.public-subnet1.id}","${aws_subnet.public-subnet2.id}", "${aws_subnet.public-subnet3.id}"]
    min_size  = 1
    desired_capacity  = 1
    max_size  = 1
    default_cooldown= 180
    health_check_grace_period = 180
    termination_policies = ["ClosestToNextInstanceHour", "NewestInstance"]
    health_check_type="EC2"
    launch_template = {
      id = "${aws_launch_template.lc-bastion.id}"
      version = "$Latest"
   }
    tag {
      key                 = "Name"
      value               = "${var.environ}-neworg-bastion-asg"
      propagate_at_launch = true
   }
}

