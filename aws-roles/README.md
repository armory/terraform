# Spinnaker AWS IAM roles

Script to creates the AWS IAM roles necessary to allow Clouddriver to interact with various AWS APIs across multiple AWS Accounts. The script creates:

* Managed Account IAM Role
* BaseIAMRole for EC2 instances
* Managing Account IAM Policy 
* Adding the Managing Account IAM Policy to the existing IAM Instance Role on the AWS node
* Configuring the Managed Accounts IAM Roles to trust the IAM Instance Role from the AWS node

## Variables

In the file "terraform.tfvars" you need to set some variables in order to execute properly.

- power-policy-arn = PowerUserAccess Policy ARN i.e. "arn:aws:iam::aws:policy/PowerUserAccess"
- arn-node = Find one of the nodes which is part of your EKS or other Kubernetes cluster and get the ARN Role i.e "arn:aws:iam::0123456789:role/armory-spin-hal-aws-dev-node"
- managed-role-name = "TestSpinnakerManagedRole"
- managing-policy = "TestDevSpinnakerManagingPolicy"
- pass-role-name = "TestPassRole"
- base-role-name = "TestBaseIAMRole"
- role-policy = "TestEc2CloudForm"