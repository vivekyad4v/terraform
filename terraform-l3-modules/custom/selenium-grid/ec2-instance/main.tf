resource "aws_key_pair" "ec2_kp" {
  key_name   = "${var.project}_${var.env}_kp"
  public_key = "${file("${path.module}/${var.pub_key_path}")}"
}

resource "aws_instance" "hub" {

  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.hub_subnet_id}"
  key_name               = "${aws_key_pair.ec2_kp.key_name}"
#  vpc_security_group_ids =  ["${var.security_groups}"]

  disable_api_termination              = "${var.disable_api_termination}"
  root_block_device {
    volume_size           = "${var.root_device_size}"
  }

  tags = "${merge(map("Name", format("%s-%s-hub", var.project, var.env)), var.default_tags, map("role", "hub"))}"
}

resource "aws_instance" "node" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.node_subnet_id}"
  key_name               = "${aws_key_pair.ec2_kp.key_name}"
#  vpc_security_group_ids =  ["${var.security_groups}"]

  disable_api_termination              = "${var.disable_api_termination}"
  root_block_device {
    volume_size           = "${var.root_device_size}"
  }

  tags = "${merge(map("Name", format("%s-%s-node", var.project, var.env)), var.default_tags, map("role", "node"))}"
}

resource "aws_eip" "heip" {
  count    = "${var.associate_eip ? 1 : 0}"
  instance = "${aws_instance.hub.id}"
  vpc      = true
}

resource "aws_eip" "neip" {
  count    = "${var.associate_eip ? 1 : 0}"
  instance = "${aws_instance.node.id}"
  vpc      = true
}

