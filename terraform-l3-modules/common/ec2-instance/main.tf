resource "aws_instance" "ec2" {
  count = "${var.instance_count}"

  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  user_data 		 = "${var.user_data}"
#  vpc_security_group_ids =  ["${var.vpc_security_group_ids}"]

  disable_api_termination              = "${var.disable_api_termination}"
  root_block_device {
    volume_size           = "${var.root_device_size}"
  }

  tags = "${merge(map("Name", format("%s-%s-ec2", var.orgname, var.environ)), var.tags)}"
}

resource "aws_eip" "eip" {
  count    = "${var.associate_eip ? 1 : 0}"
  instance = "${aws_instance.ec2.id}"
  vpc      = true
}

/* Disabled due to conflicts with other variables while using modules 
data "template_file" "init" {
  template = "${file("${var.user_data_template_path}")}"

  vars {
   ORGNAME = "${var.orgname}"
   ENVIRON = "${var.environ}"
  }
}
*/
