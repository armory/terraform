cluster-name = "terraform"
ec2-instance-type = "m5.xlarge"
max-ec2-instances = 3
min-ec2-instances = 1
desired-ec2-instances = 3
vpc-cidr-prefix = "10.6"
vpn-cidr = "0.0.0.0/0"
subnet-3rd-octet = 30
provider-region = "us-east-1"
aws-ami = "amazon-eks-node-v*"
vpc-id = "vpc-00000000000000000"
igateway-id = "igw-00000000000000000"
master-users = <<EOF
- userarn: arn:aws:iam::00000000000:user/username
  username: username
  groups:
    - system:masters
EOF
