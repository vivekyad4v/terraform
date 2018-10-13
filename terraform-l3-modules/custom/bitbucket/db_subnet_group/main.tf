resource "aws_db_subnet_group" "this" {
  count = "${var.create ? 1 : 0}"

  name_prefix = "${var.project}-${var.env}"
  subnet_ids  = ["${var.subnet_ids}"]

  tags = "${merge(map("Name", format("%s-%s", var.project, var.env)), var.default_tags)}"
}
