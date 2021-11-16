output "vpc_id" {
  value = data.aws_vpc.selected.id
}

output "github_webhook_sg_id" {
  value = data.aws_security_group.github_webhook_sg.id
}

output "github_webhook_sg_name" {
  value = data.aws_security_group.github_webhook_sg.name
}

output "all_https_sg_id" {
  value = data.aws_security_group.all_https_sg.id
}

output "all_https_sg_name" {
  value = data.aws_security_group.all_https_sg.name
}

output "armory_https_sg_id" {
  value = data.aws_security_group.armory_https_sg.id
}

output "armory_https_sg_name" {
  value = data.aws_security_group.armory_https_sg.name
}

output "armory_inbound_sg_id" {
  value = data.aws_security_group.armory_inbound_sg.id
}

output "armory_inbound_sg_name" {
  value = data.aws_security_group.armory_inbound_sg.name
}

output "spinnaker_cluster_sg_id" {
  value = data.aws_security_group.spinnaker_cluster_sg.id
}

output "spinnaker_cluster_sg_name" {
  value = data.aws_security_group.spinnaker_cluster_sg.name
}

output "spinnaker_worker_sg_id" {
  value = data.aws_security_group.spinnaker_worker_sg.id
}

output "spinnaker_worker_sg_name" {
  value = data.aws_security_group.spinnaker_worker_sg.name
}
