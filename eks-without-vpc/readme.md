# Terraform scripts for creating an EKS cluster

These scripts create an **EKS** kubernetes cluster using **AWS** as a Terraform provider, located in an existing **VPC**.  

## Mandatory variables

In the file "terraform.tfvars" you need to set some variables in order to execute properly.

- `vpc-id`: Identifier of an existing VPC.
- `subnet-1-cidr` and `subnet-2-cidr`: CIDR blocks to assign to the new subnets that will be created.
- `igateway-id`: Identifier of an existing Internet Gateway.
- `provider-region`: Region used with the AWS credentials running the scripts.

## How to Use

    terraform init 
    terraform plan
    terraform apply

## Outputs

Kubeconfig file used for connecting to the cluster, using aws-iam-authenticator as token provider.

