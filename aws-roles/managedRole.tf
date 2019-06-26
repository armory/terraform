resource "aws_iam_role_policy" "passRole" {
  name = "PassRole"
  role = "${aws_iam_role.managedRole.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

#Instance Role Part 1: Creating a Managed Account IAM Role in each your target AWS Accounts
#Instance Role Part 5: Configuring the Managed Accounts IAM Roles to trust the IAM Instance Role from the AWS nodes
resource "aws_iam_role" "managedRole" {
  name = "${var.managed-role-name}"
  description = "Allows Spinnaker Dev Cluster to perform actions in this account."
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.node-name}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = "${aws_iam_role.managedRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"

  depends_on = [
    "aws_iam_role.managedRole"
  ]
}