module "sg" {
  source = "./sg"
  
  env = "${var.env}"
  project = "${var.project}"
  region = "${var.region}"
  default_tags = "${var.default_tags}"
  vpc_id   = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = "${merge(map("Name", format("%s-%s-sg", var.project, var.env)), var.default_tags)}"
}

module "ec2-instance" {
  source = "./ec2-instance"

  env = "${var.env}"
  project = "${var.project}"
  region = "${var.region}"
  default_tags = "${var.default_tags}"
  ami                     =  "${var.ami}"
  instance_type			=  "${var.instance_type}"
  hub_subnet_id				=  "${data.terraform_remote_state.vpc.public_subnets_ids.0}"
  node_subnet_id                         =  "${data.terraform_remote_state.vpc.public_subnets_ids.0}"
  tags = "${merge(map("Name", format("%s-%s-sg", var.project, var.env)), var.default_tags)}"
}

