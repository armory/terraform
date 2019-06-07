
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

<<<<<<< HEAD
}

resource "kubernetes_service_account" "spinnaker-sa" {
  metadata {
    name      = "spinnaker"
    namespace = "default"
  }
  depends_on = ["kubernetes_config_map.aws-auth"]
}

data "kubernetes_secret" "spinnaker-token" {
  metadata {
    name = "${kubernetes_service_account.spinnaker-sa.default_secret_name}"
  }
  depends_on = ["kubernetes_service_account.spinnaker-sa"]
}

resource "kubernetes_cluster_role_binding" "spinnaker-cluster-role-binding" {
    metadata {
      name = "spinnaker-clusterrolebinding"
    }
    role_ref {
      api_group = "rbac.authorization.k8s.io"
      kind = "ClusterRole"
      name = "cluster-admin"
    }
    subject {
      api_group = ""
      kind = "ServiceAccount"
      name = "spinnaker"
      namespace = "default"
    }
    depends_on = ["kubernetes_service_account.spinnaker-sa"]
}
 
resource "kubernetes_namespace" "initial-namespace" {
  metadata {
    name = "${var.initial-namespace}"
  }
  depends_on = ["kubernetes_service_account.spinnaker-sa"]
}

=======
}
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
