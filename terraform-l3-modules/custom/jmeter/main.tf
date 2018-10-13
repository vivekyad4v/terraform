module "ec2-instance" {
  source = "../../common/ec2-instance"

orgname                =   "neworg"   ## Organisation Name
environ                =   "uat"
instance_count			=  "1"
ami                     =  "ami-66a7871c"
instance_type			=  "t2.micro"
key_name				=  "vk-kp"
subnet_id				=  "subnet-06b228d2385fc94b0"
associate_eip 				= "true"
disable_api_termination	=  "false"
root_device_size		= "12"
user_data_template_path    =  "jmeter-docker.tpl"
user_data              = "${data.template_file.jmeter.rendered}"

tags = {
    ID          = "demo"
    Creator       = "vivek"
    Environment   = "uat"
  }
}

data "template_file" "jmeter" {
  template = "${file("${var.user_data_template_path}")}"

  vars {
    JMETER_VERSION="${var.jmeter_version}"
    DOCKER_ENGINE_VERSION="${var.docker_engine_version}"
   }
}

output "id" {
  description = "List of IDs of instances"
  value       = ["${module.ec2-instance.id}"]
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = ["${module.ec2-instance.availability_zone}"]
}

output "key_name" {
  description = "List of key names of instances"
  value       = ["${module.ec2-instance.key_name}"]
}

output "EIP" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${module.ec2-instance.EIP}"]
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = ["${module.ec2-instance.subnet_id}"]
}
