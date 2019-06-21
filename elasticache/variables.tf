#
# Variables Configuration
#

variable "subnet-ids" {
  type        = "list"
  description = "CIDR block of IP addresses allocated for the subnets of the cluster"
}

variable "availability_zones" {
  type        = "list"
  description = "zones where a node of the cluster will be available."
}

variable "security_group_ids" {
  type        = "list"
  description = "List of the worker nodes sg ids."
}

variable "provider-region" {
  type        = "string"
  description = "Region used by terraform aws provider."
}