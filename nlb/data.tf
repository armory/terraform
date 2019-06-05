data "aws_instances" "eks-nodes" {
  filter {
    name   = "tag:kubernetes.io/cluster/${var.cluster-name}"
    values = ["owned"]
  }
}

data "aws_vpc" "eks_vpc" {
  filter {
    name   = "tag:kubernetes.io/cluster/${var.cluster-name}"
    values = ["shared"]
  },
  filter {
    name   = "tag:Name"
    values = ["${var.cluster-name}-node"]
  }
}

data "aws_security_group" "eks_sg_nodes" {
  vpc_id = "${data.aws_vpc.eks_vpc.id}"
  filter {
    name   = "tag:Name"
    values = ["${var.cluster-name}-node"]
  }
}

data "aws_subnet_ids" "eks_subnets" {
  vpc_id = "${data.aws_vpc.eks_vpc.id}"
  filter {
    name   = "tag:Name"
    values = ["${var.cluster-name}-node"] 
  }
}

data "aws_acm_certificate" "spin_cert" {
  domain      = "*.internal.com"
  statuses    = ["ISSUED"]
  most_recent = true
}
