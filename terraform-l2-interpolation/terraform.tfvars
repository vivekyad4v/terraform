orgname		       = "neworg"
environ		       = "uat"
vpc_cidr	       = "172.16.0.0/16"
azs                    = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets        = ["172.16.16.0/20", "172.16.32.0/20", "172.16.64.0/20"]
public_subnets         = ["172.16.96.0/20", "172.16.128.0/20", "172.16.160.0/20"]
ami_id                 = "ami-759bc50a"
pub_key_path	       = "id_rsa.pub"
bastion_instance_type  = "t2.micro"
app_instance_type      = "t2.micro"
#userdata               = ""

tags = {
    ID          = "demo"
    Creator       = "vivek"
    Environment   = "uat"
  }

