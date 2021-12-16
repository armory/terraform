# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.aws_vpc.selected.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = data.aws_vpc.selected.tags.Name
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = data.aws_vpc.selected.cidr_block
}

output "private_subnet_name" {
  description = "Name of the private subnet"
  value       = local.private_subnet_name_local
}

output "private_subnets" {
  description = "List of private subnet ids"
  value       = data.aws_subnet_ids.private.ids
}

output "public_subnet_name" {
  description = "Name of the private subnet"
  value       = local.public_subnet_name_local
}

output "public_subnets" {
  description = "List of public subnet ids"
  value       = data.aws_subnet_ids.public.ids
}

