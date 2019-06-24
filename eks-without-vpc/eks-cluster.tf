#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

#*
resource "aws_iam_role" "aws-eks-cluster" {
<<<<<<< HEAD
  name = "spinn-${var.cluster-name}-cluster"
=======
  name = "${var.cluster-name}-cluster-role"
>>>>>>> 67192546e927e3218dd143d43da29b6166495711

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws-eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.aws-eks-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "aws-eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.aws-eks-cluster.name}"
}

resource "aws_security_group" "aws-eks-cluster" {
<<<<<<< HEAD
  name        = "spinn-${var.cluster-name}-cluster"
=======
  name        = "${var.cluster-name}-cluster-sg"
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
  description = "Cluster communication with worker nodes"
  vpc_id      = "${var.vpc-id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
<<<<<<< HEAD
    Name = "spinn-${var.cluster-name}"
=======
    Name = "${var.cluster-name}-cluster"
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
  }
}

resource "aws_security_group_rule" "aws-eks-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.aws-eks-cluster.id}"
  source_security_group_id = "${aws_security_group.aws-eks-node.id}"
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "aws-eks-cluster-ingress-workstation-https" {
<<<<<<< HEAD
  cidr_blocks       = ["${var.vpn-cidr}"]
=======
  cidr_blocks       = ["${var.inbound-cidr}"]
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.aws-eks-cluster.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_eks_cluster" "aws-eks" {
<<<<<<< HEAD
  name     = "spinn-${var.cluster-name}-cluster"
=======
  name     = "${var.cluster-name}"
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
  role_arn = "${aws_iam_role.aws-eks-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.aws-eks-cluster.id}"]
<<<<<<< HEAD
    subnet_ids         = ["${aws_subnet.aws-eks.*.id}"]
=======
    subnet_ids         = ["${aws_subnet.aws-eks-subnet-1.id}", "${aws_subnet.aws-eks-subnet-2.id}"]
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
  }

  depends_on = [
    "aws_iam_role_policy_attachment.aws-eks-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.aws-eks-cluster-AmazonEKSServicePolicy",
    "aws_iam_role.aws-eks-cluster"
  ]
<<<<<<< HEAD
}
=======
}
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
