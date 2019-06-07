#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EC2 Security Group to allow networking traffic
#  * Data source to fetch latest EKS worker AMI
#  * AutoScaling Launch Configuration to configure worker instances
#  * AutoScaling Group to launch worker instances
#

resource "aws_iam_role" "aws-eks-node" {
<<<<<<< HEAD
  name = "spinn-${var.cluster-name}-node"
=======
  name = "${var.cluster-name}-node-role"
>>>>>>> 67192546e927e3218dd143d43da29b6166495711

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws-eks-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.aws-eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "aws-eks-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.aws-eks-node.name}"
}

resource "aws_iam_role_policy_attachment" "aws-eks-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.aws-eks-node.name}"
}

resource "aws_iam_instance_profile" "aws-eks-node" {
  name = "spinn-${var.cluster-name}"
  role = "${aws_iam_role.aws-eks-node.name}"
}

resource "aws_security_group" "aws-eks-node" {
<<<<<<< HEAD
  name        = "spinn-${var.cluster-name}-node"
=======
  name        = "${var.cluster-name}-node-sg"
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${var.vpc-id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
<<<<<<< HEAD
     "Name", "spinn-${var.cluster-name}-node",
=======
     "Name", "${var.cluster-name}-node",
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "aws-eks-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.aws-eks-node.id}"
  source_security_group_id = "${aws_security_group.aws-eks-node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "aws-eks-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.aws-eks-node.id}"
  source_security_group_id = "${aws_security_group.aws-eks-cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}

data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["${var.aws-ami}"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

# EKS currently documents this required userdata for EKS worker nodes to
# properly configure Kubernetes applications on the EC2 instance.
# We utilize a Terraform local here to simplify Base64 encoding this
# information into the AutoScaling Launch Configuration.
# More information: https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  aws-eks-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.aws-eks.endpoint}' --b64-cluster-ca '${aws_eks_cluster.aws-eks.certificate_authority.0.data}' '${var.cluster-name}'
USERDATA
}

resource "aws_launch_configuration" "aws-eks" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.aws-eks-node.name}"
  image_id                    = "${data.aws_ami.eks-worker.id}"
  instance_type               = "${var.ec2-instance-type}"
<<<<<<< HEAD
  name_prefix                 = "spinn-${var.cluster-name}"
=======
  name_prefix                 = "${var.cluster-name}-node"
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
  security_groups             = ["${aws_security_group.aws-eks-node.id}"]
  user_data_base64            = "${base64encode(local.aws-eks-node-userdata)}"

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_size = "50"
  }
}

resource "aws_autoscaling_group" "aws-eks" {
  desired_capacity     = "${var.desired-ec2-instances}"
  launch_configuration = "${aws_launch_configuration.aws-eks.id}"
  max_size             = "${var.max-ec2-instances}" 
  min_size             = "${var.min-ec2-instances}" 
<<<<<<< HEAD
  name                 = "spinn-${var.cluster-name}"
  vpc_zone_identifier  = ["${aws_subnet.aws-eks.*.id}"]

  tag {
    key                 = "Name"
    value               = "spinn-${var.cluster-name}"
=======
  name                 = "${var.cluster-name}-asg"
  vpc_zone_identifier  = ["${aws_subnet.aws-eks-subnet-1.id}", "${aws_subnet.aws-eks-subnet-2.id}"]

  tag {
    key                 = "Name"
    value               = "${var.cluster-name}"
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
<<<<<<< HEAD
=======

  depends_on = ["aws_eks_cluster.aws-eks"]

>>>>>>> 67192546e927e3218dd143d43da29b6166495711
}
