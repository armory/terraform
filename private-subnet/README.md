# Private Subnet

This script creates a **Private Subnet** infrastructure using **AWS** as a Provider based on an already existing **VPC** with a public subnet.  

## Variables

In the file "terraform.tfvars" you need to set some variables in order to execute properly.

- provider-region = The region where the subnet should be created 
- provider-profile = The profile provider in the .aws/credentials 
- ingress_from_port = Ingress port range for the private subnet (from)
- ingress_to_port = Ingress port range for the private subnet (to)
- vpc_id = The VPC id already existing 
- private_subnet_cidr = CIDR of the **Private** i.e. "10.6.2.0/24"
- public_subnet_cidr = CIDR of the **Public** i.e. "10.6.1.0/24"
- public_subnet_id = public SubnetId i.e. "subnet-090d5d3d3ed53212e"
- availability_zone = the availability_zone zone of the region i.e. "us-east-1b"
- ami-nat =  The NAT instance is a special Amazon Linux AMI which handles the routing correctly, i.e. "ami-eccf48fa". It can be found on the AWS Marketplace using the aws command line tool by doing something like this:

`aws ec2 describe-images --filter Name="owner-alias",Values="amazon" --filter
Name="name",Values="amzn-ami-vpc-nat*"`

## How to Use

    terraform init 
    terraform plan -var-file=terraform.tfvars
    terraform apply -var-file=terraform.tfvars

## Result

Nat, table route, security group and private subnet should be created after run the script. 