resource "aws_db_subnet_group" "this" {
  count = "${var.create ? 1 : 0}"

  name_prefix = "${var.name_prefix}"
  subnet_ids  = ["${var.subnet_ids}"]

  tags = "${merge(map("Name", format("%s-%s", var.orgname, var.environ)), var.tags)}"
}
