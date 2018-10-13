resource "aws_efs_file_system" "this" {
  creation_token  = "${var.project}-${var.env}"

  tags = "${merge(map("Name", format("%s-%s", var.project, var.env)), var.default_tags)}"
}

resource "aws_efs_mount_target" "this" {
  count           = "${length(var.subnets)}"
  file_system_id  = "${aws_efs_file_system.this.id}"
  subnet_id       = "${element(var.subnets, count.index)}"
  security_groups = ["${var.security_groups}"]
}

