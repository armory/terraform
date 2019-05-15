#
# Outputs: there are really no terraform outputs, these files are stored in an S3 bucket
#

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.aws-eks.endpoint}
    certificate-authority-data: ${aws_eks_cluster.aws-eks.certificate_authority.0.data}
  name: ${var.cluster-name}
contexts:
- context:
    cluster: ${var.cluster-name}
    user: aws
  name: ${var.cluster-name}
current-context: ${var.cluster-name}
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: heptio-authenticator-aws
      args:
        - "token"
        - "-i"
        - "${var.cluster-name}"
KUBECONFIG
}
