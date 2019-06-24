#
# Provider Configuration
#

provider "aws" {
  version = "~> 1.60.0"
  region = "${var.provider-region}"
<<<<<<< HEAD
  profile = "${var.provider-profile}"
=======
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

data "aws_eks_cluster_auth" "aws-eks-auth" {
  name       = "${aws_eks_cluster.aws-eks.name}"
}

provider "kubernetes" {
  host                   = "${aws_eks_cluster.aws-eks.endpoint}"
  cluster_ca_certificate = "${base64decode(aws_eks_cluster.aws-eks.certificate_authority.0.data)}"
  token                  = "${data.aws_eks_cluster_auth.aws-eks-auth.token}"
  load_config_file       = false
}
