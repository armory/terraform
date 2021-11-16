locals {
  vpc_name_local            = "%{ if var.add_suffix }${local.vpc_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.vpc_name}%{ endif }"
  public_subnet_name_local  = "%{ if var.add_suffix }${local.public_subnet_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.vpc_name}%{ endif }"
  private_subnet_name_local = "%{ if var.add_suffix }${local.private_subnet_name}-${data.terraform_remote_state.random_string.outputs.suffix}%{ else }${local.vpc_name}%{ endif }"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  create_vpc = var.create_vpc
  
  name = local.vpc_name_local
  cidr = var.vpc_cidr

  azs             = "${keys(var.private_subnets)}"
  private_subnets = "${values(var.private_subnets)}"
  public_subnets  = "${values(var.public_subnets)}"

  enable_ipv6 = var.enable_ipv6

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  public_subnet_tags = {
    Name               = local.public_subnet_name_local
    immutable_metadata = "{\"purpose\":\"${local.public_subnet_name_local}\"}"
  }

  private_subnet_tags = {
    Name               = local.private_subnet_name_local
    immutable_metadata = "{\"purpose\":\"${local.private_subnet_name_local}\"}"
  }

  tags = {
    env   = var.env
    owner = var.owner
  }

  vpc_tags = {
    Name  = local.vpc_name_local
    owner = var.owner
  }
}

data "aws_vpc" "selected" {
  depends_on = [ module.vpc ]

  filter {
    name = "tag:Name"
    values = ["${local.vpc_name_local}"]
  }
}

data "aws_subnet_ids" "public" {
  depends_on = [ data.aws_vpc.selected ]

  vpc_id = data.aws_vpc.selected.id

  filter {
    name = "tag:Name"
    values = [local.public_subnet_name_local]
  }
}

data "aws_subnet_ids" "private" {
  depends_on = [ data.aws_vpc.selected ]

  vpc_id = data.aws_vpc.selected.id

  filter {
    name = "tag:Name"
    values = [local.private_subnet_name_local]
  }
}
