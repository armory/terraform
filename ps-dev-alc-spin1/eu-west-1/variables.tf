variable "project_prefix" {
  default = "armory-spin-alc"
}

variable "env" {
  default = "dev"
}

variable "owner" {
  default = "alice.chen@armory.io"
}

# set this to false if you want the local values defined below to be fixed
variable "add_suffix" {
  description = "Add random suffix to all generated resources?"
  type = bool
  default = true
}

# locals are usually derived variables
# change if this needs to be a fixed value
# also set variable.add_suffix to false
locals {
  vpc_name               = "${var.project_prefix}-${var.env}-vpc"
  public_subnet_name     = "${var.project_prefix}-${var.env}-public"
  private_subnet_name    = "${var.project_prefix}-${var.env}-private"
  github_sg_name         = "${var.project_prefix}-${var.env}-github-sg"
  all_https_sg_name      = "${var.project_prefix}-${var.env}-all-https-sg"
  armory_https_sg_name   = "${var.project_prefix}-${var.env}-armory-https-sg"
  armory_all_in_sg_name  = "${var.project_prefix}-${var.env}-armory-all-sg"
  s3_bucket_name         = "${var.project_prefix}-${var.env}-bucket"
  eks_cluster_version    = "1.14"
  eks_cluster_name       = "${var.project_prefix}-${var.env}-eks-cluster"
  eks_cluster_iam_role   = "${var.project_prefix}-${var.env}-eks-cluster-role"
  eks_cluster_sg_name    = "${var.project_prefix}-${var.env}-eks-cluster-sg"
  eks_worker_sg_name     = "${var.project_prefix}-${var.env}-eks-worker-sg"
  eks_worker_iam_role    = "${var.project_prefix}-${var.env}-eks-worker-role"
  aws_ec2_base_iam_role  = "${var.project_prefix}-${var.env}-ec2-base-role"
  spinnaker_managed_role = "${var.project_prefix}-${var.env}-spinnaker-managed-role"
}

variable "region" {
  description = "The region the VPC is in"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "private_subnets" {
  description = "Map of availability zones to CIDR blocks"
  type        = map
  default     = {
    "eu-west-1a" = "10.1.1.0/24"
    "eu-west-1b" = "10.1.2.0/24"
    "eu-west-1c" = "10.1.3.0/24"
  }
}

variable "public_subnets" {
  description = "Map of availability zones to CIDR blocks"
  type        = map
  default     = {
    "eu-west-1a" = "10.1.101.0/24"
    "eu-west-1b" = "10.1.102.0/24"
    "eu-west-1c" = "10.1.103.0/24"
  }
}

variable "enable_ipv6" {
  type = bool
  default = false
}

variable "enable_nat_gateway" {
  type = bool
  default = true
}

variable "single_nat_gateway" {
  type = bool
  default = true
}

# List of Armory CIDRs to allow separated by , with NO space
# Ellsworth WiLine
# vpn.armory.io
# ATT Fiber
# Ellsworth
variable "armory_cidrs" {
  type = string
  default = "64.71.30.198/32,35.164.75.27/32,12.201.133.16/29,12.248.117.74/32"
}

# flags to create the various resources
variable "create_vpc" {
  type = bool
  default = true
}

variable "create_github_sg" {
  type = bool
  default = true
}

variable "create_all_https_sg" {
  type = bool
  default = true
}

variable "create_armory_https_sg" {
  type = bool
  default = true
}

variable "create_armory_sg" {
  type = bool
  default = true
}

variable "create_s3_bucket" {
  type = bool
  default = true
}

variable "create_spinnaker_cluster_sg" {
  type = bool
  default = true
}

variable "create_spinnaker_worker_sg" {
  type = bool
  default = true
}

variable "create_spinnaker_cluster_role" {
  type = bool
  default = true
}

variable "create_spinnaker_worker_role" {
  type = bool
  default = true
}

variable "create_aws_ec2_base_iam_role" {
  type = bool
  default = true
}

variable "create_spinnaker_managed_iam_role" {
  type = bool
  default = true
}







