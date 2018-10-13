data "null_data_source" "tags" {
  count = "${length(keys(var.default_tags))}"

  inputs = {
    key                 = "${element(keys(var.default_tags), count.index)}"
    value               = "${element(values(var.default_tags), count.index)}"
    propagate_at_launch = true
  }
}

resource "aws_key_pair" "ec2_kp" {
  key_name   = "${var.project}_${var.env}_kp"
  public_key = "${file("${path.module}/${var.pub_key_path}")}"
}

data "template_file" "init" {
  template = "${file("${path.module}/${var.userdata_template_path}")}"

  vars {
    MOUNT_TARGET_DNS="${var.mount_target_dns}"        
   }
}

resource "aws_launch_configuration" "lc_ec2" {

  name_prefix = "${var.project}-${var.env}-lc-ec2"
  image_id = "${var.ami_id}"
  instance_type = "${var.app_instance_type}"
  key_name = "${var.project}_${var.env}_kp"            
  security_groups = ["${var.security_groups}"]      	
  user_data = "${data.template_file.init.rendered}"
  root_block_device {
    volume_size = 15
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_ec2" {
    name = "${var.project}-${var.env}-asg-ec2-${aws_launch_configuration.lc_ec2.name}"

    vpc_zone_identifier = ["${var.private_subnet_ids}"]
    min_size  = 1
    desired_capacity  = 1
    max_size  = 1
    target_group_arns = ["${var.target_group_arns}"]			
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
      value               = "${var.project}-${var.env}-asg-ec2"
      propagate_at_launch = true
       }
     ]
}
