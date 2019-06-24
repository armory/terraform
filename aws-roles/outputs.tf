data "aws_caller_identity" "current" {}

locals {
  spinnaccount = "export AWS_ACCOUNT_NAME=aws-dev-1"
  account = "export ACCOUNT_ID=${data.aws_caller_identity.current.account_id}"
  rolename = "export ROLE_NAME=role/${aws_iam_role.managedRole.name}"
  halconfig = "hal config provider aws account add $AWS_ACCOUNT_NAME --account-id $ACCOUNT_ID --assume-role $ROLE_NAME"
  halenable = "hal config provider aws enable"
  haldeploy = "hal deploy apply"
}

output "commands" {
  value = "Run this commands in order: \n1) ${local.spinnaccount} \n2) ${local.account} \n3) ${local.rolename} \n4) ${local.halconfig} \n5) ${local.halenable} \n6) ${local.haldeploy}"
}