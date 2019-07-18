
resource "kubernetes_config_map" "aws-auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data {
    mapRoles = <<ROLES
- groups:
  - system:bootstrappers
  - system:nodes
  rolearn: ${aws_iam_role.aws-eks-node.arn}
  username: system:node:{{EC2PrivateDNSName}}
ROLES
    mapUsers = "${var.master-users}"
  }

  depends_on = ["aws_autoscaling_group.aws-eks"]

}
