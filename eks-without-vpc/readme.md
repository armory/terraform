# EKS without VPC

This script creates a **EKS** infrastructure using **AWS** as a Provider based on a already existing **VPC**.  

## Variables

In the file "terraform.tfvars" you need to set some variables in order to execute properly.

- vpc-id: The VPC id from an already exist VPC
- initial-namespace: The initial namespace
- aws-ami-eks: the image ID for EKS example: 602401143452
- igateway-id: The Internet Gateway ID already created
- _arn:aws:iam_ same for the "username": the amazon resource name

## How to Use

    terraform init 
    terraform plan -var-file=terraform.tfvars
    terraform apply -var-file=terraform.tfvars

You can rename the current file by clicking the file name in the navigation bar or by clicking the **Rename** button in the file explorer.

## Result

After run the script the infrastructure should be created and the output is the kubeconfig necessary to connect to the cluster.

