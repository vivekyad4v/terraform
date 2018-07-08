[![LinkedIn](https://github.com/vivekyad4v/public-images/raw/master/generic/LinkedIn-vivekyad4v.png)](https://www.linkedin.com/in/vivekyad4v/)

<a href="https://github.com/vivekyad4v?tab=followers"><img align="right" width="200" height="183" src="https://s3.amazonaws.com/github/ribbons/forkme_left_green_007200.png" /></a>

## Terraform for beginners - Lession 1 (Launch a basic AWS infrastructure)
   * Create VPC with 3 public & private subnets spanned across 3 AZs with internet & NAT Gateway.
   * Create IAM policies, roles & instance profiles.
   * Create Autoscaling groups, Launch templates & SSH Key pairs for Application & Bastion host.
   * Create Target group & Application load balancer.
   * Create security groups for Application, ALB, Bastion & Databse instance.

### Clone this repo - 
```sh
git clone https://github.com/vivekyad4v/terraform.git
cd terraform/terraform-basics-l1  # Goto working directory
```

### Install terraform (Works for Linux & MAC OS) 
For Linux -
```sh
mv terraform-0.11.7-linux-amd-64 terraform
```
For MAC OS -
```sh
mv terraform-for-mac-0.11.7 terraform
```
### Export AWS secret keys, else define them in `aws-provider.tf` -
```sh
export AWS_ACCESS_KEY_ID=AKIA********
export AWS_SECRET_ACCESS_KEY=8s8v1lT*******************
export AWS_DEFAULT_REGION=us-east-1
```
### Initialize terraform - 
```sh
./terraform init
```
### Plan (shows execution plan) - 
```sh
./terraform plan -out terraform-plan-key
```
### Apply (Creates the defined infrastructe) - 
```sh
./terraform apply terraform-plan-key
```
### Output - 
You will get the ALB DNS name in the output. Open the ALB URL in your browser to see the magic.

### Destroy the infra which we build just now - 
```sh
./terraform destroy
```

Please fork/star it, if you like it :-) 
