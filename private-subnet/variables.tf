variable "vpc_id" {
  type        = "string"
  description = "Existing VPC"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "10.6.2.0/24"
}

variable "public_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "10.6.2.0/24"
}

variable "ingress_from_port" {
  type        = "string"
  description = "Ingress From Port "
}

variable "ingress_to_port" {
  type        = "string"
  description = "Ingress To Port"
}

variable "public_subnet_id" {
  type        = "string"
  description = "Public Subnet"
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

variable "availability_zone"{
	type        = "string"
}

variable "ami-nat"{
	type        = "string"
	description = "The NAT instance is a special Amazon Linux AMI which handles the routing correctly."
}
