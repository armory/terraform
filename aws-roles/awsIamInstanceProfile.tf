resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = "${aws_iam_role.managedRole.name}"

  depends_on = [
    "aws_iam_role.managedRole"
  ]
}