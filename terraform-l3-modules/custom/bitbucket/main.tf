module "sg" {
  source = "./sg"
  
  env = "${var.env}"
  project = "${var.project}"
  region = "${var.region}"
  default_tags = "${var.default_tags}"
  project = "${var.project}"
  env = "${var.env}"
  vpc_id   = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = "${merge(map("Name", format("%s-%s-sg", var.project, var.env)), var.default_tags)}"
}

module "alb" {
  source = "./alb"

  env = "${var.env}"
  project = "${var.project}"
  region = "${var.region}"
  default_tags = "${var.default_tags}"
  project = "${var.project}"
  env = "${var.env}"
  vpc_id   = "${data.terraform_remote_state.vpc.vpc_id}"
  subnets   = ["${data.terraform_remote_state.vpc.public_subnets_ids}"]
  security_groups   = ["${module.sg.aws_security_group_alb_id}"]

  tags = "${merge(map("Name", format("%s-%s-alb", var.project, var.env)), var.default_tags)}"
}

module "asg" {
  source = "./asg"

  env = "${var.env}"
  project = "${var.project}"
  region = "${var.region}"
  default_tags = "${var.default_tags}"
  project = "${var.project}"
  env = "${var.env}"
  private_subnet_ids   = ["${data.terraform_remote_state.vpc.private_subnets_ids}"]
  mount_target_dns   = "${module.efs.mount_target_dns}"
  target_group_arns   = ["${module.alb.target_group_id}"]
  security_groups   = ["${module.sg.aws_security_group_ec2_id}"]

  tags = "${merge(map("Name", format("%s-%s-asg", var.project, var.env)), var.default_tags)}"
}

module "db_subnet_group" {
  source = "./db_subnet_group"

  env = "${var.env}"
  project = "${var.project}"
  region = "${var.region}"
  default_tags = "${var.default_tags}"
  project = "${var.project}"
  env = "${var.env}"
  subnet_ids  = ["${data.terraform_remote_state.vpc.private_subnets_ids}"]

  tags = "${merge(map("Name", format("%s-%s-db", var.project, var.env)), var.default_tags)}"
}

module "db_instance" {
  source = "./db_instance"

  env = "${var.env}"
  project = "${var.project}"
  region = "${var.region}"
  default_tags = "${var.default_tags}"
  project = "${var.project}"
  env = "${var.env}"
  identifier           = "${var.project}-${var.env}"
  name                                = "${var.name}"
  username                            = "${var.username}"
  password                            = "${var.password}"
  vpc_security_group_ids = ["${module.sg.aws_security_group_db_id}"]
  db_subnet_group_name   = "${module.db_subnet_group.this_db_subnet_group_id}"
  multi_az            = "${var.multi_az}"

  tags = "${merge(map("Name", format("%s-%s-db", var.project, var.env)), var.default_tags)}"
}

module "efs" {
  source = "./efs"

  env = "${var.env}"
  project = "${var.project}"
  region = "${var.region}"
  default_tags = "${var.default_tags}"
  project = "${var.project}"
  env = "${var.env}"
  subnets   = ["${data.terraform_remote_state.vpc.private_subnets_ids}"]
  security_groups   = ["${module.sg.aws_security_group_efs_id}"]

  tags = "${merge(map("Name", format("%s-%s-efs", var.project, var.env)), var.default_tags)}"
}

module "es" {
  source = "./es"

  env = "${var.env}"
  project = "${var.project}"
  region = "${var.region}"
  default_tags = "${var.default_tags}"
  vpc_options {
    security_group_ids = ["${module.sg.aws_security_group_es_id}"]
    subnet_ids         = ["${slice(data.terraform_remote_state.vpc.private_subnets_ids, 0, 2)}"]
    }

  tags = "${merge(map("Name", format("%s-%s-es", var.project, var.env)), var.default_tags)}"
}


