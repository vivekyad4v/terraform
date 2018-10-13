module "ec2instance" {
  source = "../common/ec2-instance"

orgname                =   "myapp-neworg"
environ                =   "uat"
instance_count			=  "1"
ami                     =  "ami-759bc50a"
instance_type			=  "t2.micro"
key_name				=  "vk-kp"
subnet_id				=  "${data.terraform_remote_state.vpc.public_subnets_ids.0}"
associate_eip 				= "true"
disable_api_termination	=  "false"
root_device_size		= "12"
user_data_template_path    =  "./common/ec2-instance/apache.tpl"

tags = {
    ID          = "demo"
    Creator       = "vivek"
    Environment   = "uat"
  }
}

/*
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

*/

resource "null_resource" "list_files" {
    provisioner "local-exec" {
        command = "ls -l"
    }
}
