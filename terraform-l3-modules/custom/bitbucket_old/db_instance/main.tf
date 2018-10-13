resource "aws_db_instance" "this" {
  count = "${var.create ? 1 : 0}"

  identifier = "${var.orgname}-${var.environ}"
  engine            = "${var.engine}"
  engine_version    = "${var.engine_version}"
  instance_class    = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"
  name                                = "${var.name}"
  username                            = "${var.username}"
  password                            = "${var.password}"
  port                                = "${var.port}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name   = "${var.db_subnet_group_name}"
  multi_az            = "${var.multi_az}"
  publicly_accessible = "${var.publicly_accessible}"
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  backup_retention_period = "${var.backup_retention_period}"
  skip_final_snapshot         = "${var.skip_final_snapshot}"
  final_snapshot_identifier   = "${var.final_snapshot_identifier}"

  tags = "${merge(map("Name", format("%s-%s", var.orgname, var.environ)), var.tags)}"
}

