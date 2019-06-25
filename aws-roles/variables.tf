variable "provider-region" {
  type        = "string"
  description = "Region used by terraform aws provider."
}

variable "provider-profile" {
  type        = "string"
  description = "Profile of AWS credentials file to use"
}

variable "power-policy-arn" {
  type        = "string"
  description = "PowerPolicy ARN"
}

variable "node-name" {
  type        = "string"
  description = "Node ARN"
}

variable "managed-role-name" {
  type        = "string"
  default     = "SpinnakerManagedRole"
  description = "Role Name"
}

variable "base-role-name" {
  type        = "string"
  default     = "BaseIAMRole"
  description = "BaseIAMRole"
}

variable "role-policy" {
  type        = "string"
  default     = "Ec2CloudForm"
}

variable "managing-policy" {
  type        = "string"
  default     = "TestDevSpinnakerManagingPolicy"
}

variable "managing-role-instance-profile" {
  type        = "string"
  default     = "managed-role-instance-profile"
}