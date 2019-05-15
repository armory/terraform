#
# Variables Configuration
#

variable "cluster-name" {
  type    = "string"
  default = "spinnaker"
}

variable "ec2-instance-type" {
  type    = "string"
  default = "m5.xlarge"
}

variable "max-ec2-instances" {
  default = 3 
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

variable "vpc-id" {
  type        = "string"
}

variable "subnet-3rd-octet" {
  description = "Third octet of the subnets for this cluster. Ex: 3"
}


variable "igateway-id" {
  type        = "string"
  description = "Identifier of an internet gateway associated with the VPC."
}