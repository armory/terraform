resource "aws_iam_role_policy" "passRole" {
  name = "${var.pass-role-name}"
  role = "${aws_iam_role.managedRole.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:${var.pass-role-name}"
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
        "AWS": "${var.arn-node}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${aws_iam_role.managedRole.name}"
  policy_arn = "${var.power-policy-arn}"

  depends_on = [
    "aws_iam_role.managedRole"
  ]
}