locals {
  db_subnet_group_name          = "${coalesce(var.db_subnet_group_name, module.db_subnet_group.this_db_subnet_group_id)}"
  enable_create_db_subnet_group = "${var.db_subnet_group_name == "" ? var.create_db_subnet_group : 0}"
}

module "db_subnet_group" {
  source = "./db_subnet_group"

  create      = "${var.enable_create_db_subnet_group}"
  subnet_ids  = ["subnet-0d0d862bb8fc1104f", "subnet-08a2f3dd0c14f2913", "subnet-0d9ebbcb7cc163eb4"]
  orgname 	      = "${var.orgname}"
  environ      = "${var.environ}"

  tags = "${merge(map("Name", format("%s-%s", var.orgname, var.environ)), var.tags)}"
}

module "db_instance" {
  source = "./db_instance"

  create            = "${var.create_db_instance}"
  identifier = "${var.orgname}-${var.environ}"
  engine            = "${var.engine}"
  engine_version    = "${var.engine_version}"
  instance_class    = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"
  name                                = "${var.orgname}"
  username                            = "${var.username}"
  password                            = "${var.password}"
  port                                = "${var.port}"
#  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  db_subnet_group_name   = "${local.db_subnet_group_name}"
  multi_az            = "${var.multi_az}"
  publicly_accessible = "${var.publicly_accessible}"
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  backup_retention_period = "${var.backup_retention_period}"

  tags = "${merge(map("Name", format("%s-%s", var.orgname, var.environ)), var.tags)}"
}
