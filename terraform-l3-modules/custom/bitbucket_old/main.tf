module "sg" {
  source = "./sg"
  
  orgname = "${var.orgname}"
  environ = "${var.environ}"
  vpc_id   = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = "${merge(map("Name", format("%s-%s-sg", var.orgname, var.environ)), var.tags)}"
}

module "alb" {
  source = "./alb"

  orgname = "${var.orgname}"
  environ = "${var.environ}"
  vpc_id   = "${data.terraform_remote_state.vpc.vpc_id}"
  subnets   = ["${data.terraform_remote_state.vpc.public_subnets_ids}"]
  security_groups   = ["${module.sg.aws_security_group_alb_id}"]

  tags = "${merge(map("Name", format("%s-%s-alb", var.orgname, var.environ)), var.tags)}"
}

module "asg" {
  source = "./asg"

  orgname = "${var.orgname}"
  environ = "${var.environ}"
  private_subnet_ids   = ["${data.terraform_remote_state.vpc.private_subnets_ids}"]
  mount_target_dns   = "${module.efs.mount_target_dns}"
  target_group_arns   = ["${module.alb.target_group_id}"]
  security_groups   = ["${module.sg.aws_security_group_ec2_id}"]

  tags = "${merge(map("Name", format("%s-%s-asg", var.orgname, var.environ)), var.tags)}"
}

module "db_subnet_group" {
  source = "./db_subnet_group"

  orgname = "${var.orgname}"
  environ = "${var.environ}"
  subnet_ids  = ["${data.terraform_remote_state.vpc.private_subnets_ids}"]

  tags = "${merge(map("Name", format("%s-%s-db", var.orgname, var.environ)), var.tags)}"
}

module "db_instance" {
  source = "./db_instance"

  orgname = "${var.orgname}"
  environ = "${var.environ}"
  identifier           = "${var.orgname}-${var.environ}"
  name                                = "${var.name}"
  username                            = "${var.username}"
  password                            = "${var.password}"
  vpc_security_group_ids = ["${module.sg.aws_security_group_db_id}"]
  db_subnet_group_name   = "${module.db_subnet_group.this_db_subnet_group_id}"
  multi_az            = "${var.multi_az}"

  tags = "${merge(map("Name", format("%s-%s-db", var.orgname, var.environ)), var.tags)}"
}

module "efs" {
  source = "./efs"

  orgname = "${var.orgname}"
  environ = "${var.environ}"
  subnets   = ["${data.terraform_remote_state.vpc.private_subnets_ids}"]
  security_groups   = ["${module.sg.aws_security_group_efs_id}"]

  tags = "${merge(map("Name", format("%s-%s-efs", var.orgname, var.environ)), var.tags)}"
}

module "es" {
  source = "./es"

  vpc_options {
    security_group_ids = ["${module.sg.aws_security_group_es_id}"]
    subnet_ids         = ["${slice(data.terraform_remote_state.vpc.private_subnets_ids, 0, 2)}"]
    }

  tags = "${merge(map("Name", format("%s-%s-es", var.orgname, var.environ)), var.tags)}"
}


