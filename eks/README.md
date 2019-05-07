# EKS with VPC Terraform Script

This script creates a **EKS** infrastructure using **AWS** as a Provider and also creates the appropriate **VPC**.  

## Variables

In the file "terraform.tfvars" you need to set some variables in order to execute properly.

- cluster-name: the name of the cluster. *Note: this script adds a prefix to the name: _spin-_
- mater-users: change the "arn:aws:iam::000000000000:user" with your _arn:aws:iam_ same for the "username".

## How to Use

    terraform init 
    terraform plan -var-file=terraform.tfvars
    terraform apply -var-file=terraform.tfvars

## Result

After run the script the infrastructure should be created and the output is the kubeconfig necessary to connect to the cluster. 
