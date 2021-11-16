locals {
  eks_cluster_name_local = "%{ if var.add_suffix }${local.eks_cluster_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.eks_cluster_name}%{ endif }"
  eks_cluster_iam_role_local = "%{ if var.add_suffix }${local.eks_cluster_iam_role}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.eks_cluster_iam_role}%{ endif }"
  eks_worker_iam_role_local = "%{ if var.add_suffix }${local.eks_worker_iam_role}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.eks_worker_iam_role}%{ endif }"
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${data.terraform_remote_state.vpc.outputs.vpc_name}"]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id
  
  tags = {
    Name = data.terraform_remote_state.vpc.outputs.private_subnet_name
  }
}

data "aws_ami" "worker" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amazon-eks-node-${local.eks_cluster_version}-v*"]
  }
}

output "subnet_ids" {
  value = data.aws_subnet_ids.private.ids
}

output "ami_id" {
  value = data.aws_ami.worker.id
}

output "ami_name" {
  value = data.aws_ami.worker.name
}


data "aws_eks_cluster" "cluster" {
  name = module.spin-eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.spin-eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "spin-eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-cluster"
  cluster_version = "1.18"
  subnets         = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  vpc_id          = data.aws_vpc

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size  = 5
    }
  ]
}

