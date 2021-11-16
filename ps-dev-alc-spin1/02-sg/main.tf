data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${data.terraform_remote_state.vpc.outputs.vpc_name}"]
  }
}

locals {
  github_webhook_name_local = "%{ if var.add_suffix }${local.github_sg_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.github_sg_name}%{ endif }"
  all_https_name_local      = "%{ if var.add_suffix }${local.all_https_sg_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.all_https_sg_name}%{ endif }"
  armory_https_name_local   = "%{ if var.add_suffix }${local.armory_https_sg_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.armory_https_sg_name}%{ endif }"
  armory_inbound_name_local = "%{ if var.add_suffix }${local.armory_all_in_sg_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.armory_all_in_sg_name}%{ endif }"
  eks_cluster_sg_local = "%{ if var.add_suffix }${local.eks_cluster_sg_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.eks_cluster_sg_name}%{ endif }"
  eks_worker_sg_local = "%{ if var.add_suffix }${local.eks_worker_sg_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.eks_worker_sg_name}%{ endif }"
}

module "github_webhook_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  create          = var.create_github_sg
  use_name_prefix = false
  
  name        = local.github_webhook_name_local
  description = "Allow inbound GitHub webhook"
  vpc_id      = data.aws_vpc.selected.id

  ingress_cidr_blocks = ["192.30.252.0/22", "185.199.108.0/22", "140.82.112.0/20"]
  ingress_rules       = ["https-443-tcp"]

  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  tags = {
    owner = var.owner
  }
}

module "all_https_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  create = var.create_all_https_sg
  use_name_prefix = false
  
  name        = local.all_https_name_local
  description = "Allow inbound HTTPS/TLS from all"
  vpc_id      = data.aws_vpc.selected.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp"]

  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  tags = {
    owner = var.owner
  }
}

module "armory_https_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  create = var.create_armory_https_sg
  use_name_prefix = false
  
  name        = local.armory_https_name_local
  description = "Allow inbound HTTPS/TLS from Armory"
  vpc_id      = data.aws_vpc.selected.id

  ingress_cidr_blocks = split(",", var.armory_cidrs)
  ingress_rules       = ["https-443-tcp"]

  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  tags = {
    owner = var.owner
  }
}

module "armory_inbound_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  create = var.create_armory_sg
  use_name_prefix = false
  
  name        = local.armory_inbound_name_local
  description = "Allow inbound from Armory"
  vpc_id      = data.aws_vpc.selected.id

  ingress_with_cidr_blocks = [
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      description = "Allow ICMP from Armory"
      cidr_blocks = var.armory_cidrs
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      description = "Allow all inbound from Armory"
      cidr_blocks = var.armory_cidrs
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      description = "Allow all from VPC"
      cidr_blocks = var.vpc_cidr
    },
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      description = "Allow ICMP from VPC"
      cidr_blocks = var.vpc_cidr
    },
  ]

  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  tags = {
    owner = var.owner
  }
}

module "spinnaker_cluster_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  create = var.create_spinnaker_cluster_sg
  use_name_prefix = false

  name        = local.eks_cluster_sg_local
  description = "Allow inbound HTTPS/TLS from all for EKS cluster"
  vpc_id      = data.aws_vpc.selected.id

  ingress_cidr_blocks = concat(split(",", var.armory_cidrs), [var.vpc_cidr])
  ingress_rules       = ["https-443-tcp"]

  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  tags = {
    owner = var.owner
    env   = var.env
  }
}

module "spinnaker_worker_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  create = var.create_spinnaker_worker_sg
  use_name_prefix = false

  name        = local.eks_worker_sg_local
  description = "Allow inbound for EKS workers"
  vpc_id      = data.aws_vpc.selected.id

  ingress_with_self   = [
    {
      rule        = "all-all"
      description = "Allow node to communicate with each other"
    },
  ]

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = "${data.aws_security_group.spinnaker_cluster_sg.id}"
      description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  tags = {
    owner = var.owner
    env   = var.env
  }
}

resource "aws_security_group_rule" "spinnaker_cluster_worker_rule" {
  depends_on = [ module.spinnaker_cluster_sg, module.spinnaker_worker_sg ]

  count = var.create_spinnaker_cluster_sg ? 1 : 0

  security_group_id = module.spinnaker_cluster_sg.this_security_group_id

  type                     = "ingress"
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = module.spinnaker_worker_sg.this_security_group_id
}


data "aws_security_group" "github_webhook_sg" {
  depends_on = [ module.github_webhook_sg ]

  vpc_id = data.aws_vpc.selected.id
  name   = local.github_webhook_name_local
}

data "aws_security_group" "all_https_sg" {
  depends_on = [ module.all_https_sg ]

  vpc_id = data.aws_vpc.selected.id
  name   = local.all_https_name_local
}

data "aws_security_group" "armory_https_sg" {
  depends_on = [ module.armory_https_sg ]

  vpc_id = data.aws_vpc.selected.id
  name   = local.armory_https_name_local
}

data "aws_security_group" "armory_inbound_sg" {
  depends_on = [ module.armory_inbound_sg ]

  vpc_id = data.aws_vpc.selected.id
  name   = local.armory_inbound_name_local
}

data "aws_security_group" "spinnaker_cluster_sg" {
  depends_on = [ module.spinnaker_cluster_sg ]

  vpc_id = data.aws_vpc.selected.id
  name   = local.eks_cluster_sg_local
}

data "aws_security_group" "spinnaker_worker_sg" {
  depends_on = [ module.spinnaker_worker_sg ]

  vpc_id = data.aws_vpc.selected.id
  name   = local.eks_worker_sg_local
}

