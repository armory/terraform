locals {
  eks_cluster_name_local = "%{ if var.add_suffix }${local.eks_cluster_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.eks_cluster_name}%{ endif }"
  eks_cluster_iam_role_local = "%{ if var.add_suffix }${local.eks_cluster_iam_role}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.eks_cluster_iam_role}%{ endif }"
  eks_worker_iam_role_local = "%{ if var.add_suffix }${local.eks_worker_iam_role}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.eks_worker_iam_role}%{ endif }"
  aws_ec2_base_iam_role_local = "%{ if var.add_suffix }${local.aws_ec2_base_iam_role}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.aws_ec2_base_iam_role}%{ endif }"
  spinnaker_managed_iam_role_local = "%{ if var.add_suffix }${local.spinnaker_managed_role}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.spinnaker_managed_role}%{ endif }"
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [data.terraform_remote_state.vpc.outputs.vpc_name]
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

module "spinnaker_cluster_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 2.0"

  create_role = var.create_spinnaker_cluster_role

  role_name         = local.eks_cluster_iam_role_local
  role_requires_mfa = false

  trusted_role_services = [
    "eks.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
  ]
}

data "aws_iam_role" "spinnaker_cluster_role" {
  depends_on = [ module.spinnaker_cluster_role ]

  name = local.eks_cluster_iam_role_local
}

module "spinnaker_worker_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 2.0"

  create_role = var.create_spinnaker_worker_role

  role_name         = local.eks_worker_iam_role_local
  role_requires_mfa = false

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]
}

data "aws_iam_role" "spinnaker_worker_role" {
  depends_on = [ module.spinnaker_worker_role ]

  name = local.eks_worker_iam_role_local
}

module "aws_ec2_base_iam_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 2.0"

  role_name         = local.aws_ec2_base_iam_role_local
  role_requires_mfa = false

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
  ]
}

data "aws_iam_role" "aws_ec2_base_iam_role" {
  depends_on = [ module.aws_ec2_base_iam_role ]

  name = local.aws_ec2_base_iam_role_local
}

module "spinnaker_managed_iam_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 2.0"

  create_role = var.create_spinnaker_managed_iam_role

  role_name         = local.spinnaker_managed_iam_role_local
  role_requires_mfa = false

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
  ]
}

data "aws_iam_role" "spinnaker_managed_iam_role" {
  depends_on = [ module.spinnaker_managed_iam_role ]

  name = local.spinnaker_managed_iam_role_local
}






output "spinnaker_cluster_role_id" {
  value = data.aws_iam_role.spinnaker_cluster_role.id
}

output "spinnaker_cluster_role_arn" {
  value = data.aws_iam_role.spinnaker_cluster_role.arn
}

output "spinnaker_worker_role_id" {
  value = data.aws_iam_role.spinnaker_worker_role.id
}

output "spinnaker_worker_role_arn" {
  value = data.aws_iam_role.spinnaker_worker_role.arn
}

