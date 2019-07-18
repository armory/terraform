#Instance Role Part 2: Creating the BaseIAMRole for EC2 instances

resource "aws_iam_role_policy" "Ec2CloudForm" {
  name = "${var.role-policy}"
  role = "${aws_iam_role.baseIamRole.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Sid": "",
            "Action": [
                "ec2:*",
                "cloudformation:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


resource "aws_iam_role" "baseIamRole" {
  name = "${var.base-role-name}"
   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}