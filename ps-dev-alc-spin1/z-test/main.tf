data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${data.terraform_remote_state.vpc.outputs.vpc_name}"]
  }
}

data "aws_security_group" "github_webhook_sg" {
  vpc_id = "vpc-5fb10425"
  name   = "my_sec_group"
}



output "vpc_id" {
  value = data.aws_vpc.selected.id
}

output "github_webhook_sg_id" {
  value = data.aws_security_group.github_webhook_sg.id
}

output "github_webhook_sg_name" {
  value = data.aws_security_group.github_webhook_sg.name
}

