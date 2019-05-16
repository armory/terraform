#
# Variables Configuration
#

variable "cluster-name" {
  type    = "string"
  default = "spinnaker"
}

variable "vpc-id" {
  type        = "string"
  description = "ID of VPC where the cluster will be created"
}

variable "subnet-1-cidr" {
  type        = "string"
  description = "CIDR block of IP addresses allocated for the first subnet of the cluster"
}

variable "subnet-2-cidr" {
  type        = "string"
  description = "CIDR block of IP addresses allocated for the second subnet of the cluster"
}

variable "igateway-id" {
  type        = "string"
  description = "Identifier of an internet gateway associated with the VPC."
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
  default = 3 
}

variable "aws-ami" {
  type        = "string"
  default     = "amazon-eks-node-1.11*"
  description = "Filter for matching AMI's to use for worker nodes. Ex: amazon-eks-node-1.11*"
}

variable "provider-region" {
  type        = "string"
  description = "Region used by terraform aws provider."
}

variable "inbound-cidr" {
  type        = "string"
  description = "CIDR block of IP addresses allowed to connect to the cluster from the outside world."
  default     = "0.0.0.0/0"
}

variable "master-users" {
  type        = "string"
  description = "List of ARN's of master users of the cluster."
}

