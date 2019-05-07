#
# Variables Configuration
#

variable "cluster-name" {
  type    = "string"
}

variable "ec2-instance-type" {
  type    = "string"
}

variable "max-ec2-instances" {
  default = 1 
}

variable "min-ec2-instances" {
  default = 1 
}

variable "desired-ec2-instances" {
  default = 1 
}

variable "vpc-cidr-prefix" {
  type        = "string"
  description = "First two octets of the subnets that are going to be used by the cluster. Ex: 10.0"
}

variable "provider-region" {
  type        = "string"
  description = "Region used by terraform aws provider."
}

variable "provider-profile" {
  type        = "string"
  default     = "default"
  description = "Profile of AWS credentials file to use"
}

variable "vpn-cidr" {
  type        = "string"
  description = "CIDR block of IP addresses allowed to connect to the cluster from the outside world."
}

variable "aws-ami" {
  type        = "string"
  default     = "amazon-eks-node-1.11*"
  description = "Filter for matching AMI's to use for worker nodes. Ex: amazon-eks-node-1.11*"
}

variable "master-users" {
  type        = "string"
  description = "List of ARN's of master users of the cluster."
}

variable "aws-ami-eks" {
  type        = "string"
  description = "Amazon EKS AMI Account ID."
}