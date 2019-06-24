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
- managed-role-name = The name of the managed role, whatever you want "TestSpinnakerManagedRole"
- managing-policy = The name of the managed policy, whatever you want "TestDevSpinnakerManagingPolicy"
- pass-role-name = The name of the pass-role, whatever you want "TestPassRole"
- base-role-name =  The name of the base-role, whatever you want "TestBaseIAMRole"
- role-policy = The name of the role-policy, whatever you want "TestEc2CloudForm"


After running this, you need to continue with the guide at:
https://docs.armory.io/spinnaker-install-admin-guides/add-aws-account-iam/#instance-role-part-6-adding-the-managed-accounts-to-spinnaker-via-halyard

Take the outputs from terraform and continue from there.