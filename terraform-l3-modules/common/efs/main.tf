locals {
  efs_dns_name   = "${element(concat(aws_efs_mount_target.this.*.dns_name, list("")), 0)}"
}

resource "aws_efs_file_system" "this" {
  creation_token  = "${var.orgname}-${var.environ}"

  tags = "${merge(map("Name", format("%s-%s", var.orgname, var.environ)), var.tags)}"
}

resource "aws_efs_mount_target" "this" {
  count           = "${length(var.subnets)}"
  file_system_id  = "${aws_efs_file_system.this.id}"
  subnet_id       = "${element(var.subnets, count.index)}"
  security_groups = ["${aws_security_group.this-efs.*.id}"]
}

data "template_file" "efs-mount" {
  template = "${file("efs-mount.tpl")}"
  vars {
    MOUNT_TARGET_DNS= "${local.efs_dns_name}"
  }
} 

module "ec2-instance" {
  source = "../../common/ec2-instance"

orgname                =   "neworg"   ## Organisation Name
environ                =   "uat"
instance_count			=  "1"
ami                     =  "ami-759bc50a"
instance_type			=  "t2.micro"
key_name				=  "vk-kp"
subnet_id				=  "subnet-06b228d2385fc94b0"
associate_eip 				= "true"
disable_api_termination	=  "false"
root_device_size		= "12"
user_data_template_path    =  "efs-mount.tpl"
user_data              = "${data.template_file.efs-mount.rendered}"
vpc_security_group_ids  = ["${aws_security_group.this-ec2.*.id}"]

tags = {
    ID          = "demo"
    Creator       = "vivek"
    Environment   = "uat"
  }
}

