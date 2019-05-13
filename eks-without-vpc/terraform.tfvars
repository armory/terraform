cluster-name = "terraform"
ec2-instance-type = "m5.xlarge"
max-ec2-instances = 3
min-ec2-instances = 1
desired-ec2-instances = 3
vpc-cidr-prefix = "10.6"
vpn-cidr = "0.0.0.0/0"
subnet-3rd-octet = 30
provider-region = "us-east-1"
provider-profile = "ps"
aws-ami = "amazon-eks-node-v*"
aws-ami-eks = "999999999999"
create_vpc = "false"
vpc-id = "vpc-00000xxxx0000xxx000"
initial-namespace = "spin-ns"
igateway-id = "igw-0edf407544a944794"
master-users = <<EOF
- userarn: arn:aws:iam::0000000000:user/username
  username: username
  groups:
    - system:masters
EOF

