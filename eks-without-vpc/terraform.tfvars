cluster-name = "spinnaker"
vpc-id = "vpc-00000000"
subnet-1-cidr = "0.0.0.0/0"
subnet-2-cidr = "0.0.0.0/0"
igateway-id = "igw-00000000"
provider-region = "us-west-2"
master-users = <<EOF
- userarn: arn:aws:iam::000000000000:user/name
  username: name
  groups:
    - system:masters
EOF