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
  name: spin-${var.cluster-name}
contexts:
- context:
    cluster: spin-${var.cluster-name}
    user: aws
  name: spin-${var.cluster-name}
current-context: spin-${var.cluster-name}
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
        - "token"
        - "-i"
        - "spin-${var.cluster-name}"
      command: aws-iam-authenticator
      env:
      - name: AWS_PROFILE
        value: default
KUBECONFIG
}


#replace by output in order to print the kubeconfig
 output "kubeconfig" {
  value = "${local.kubeconfig}"
}
