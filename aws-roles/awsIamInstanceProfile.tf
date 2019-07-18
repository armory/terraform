resource "aws_iam_instance_profile" "mr-instance-profile" {
  name = "${var.managing-role-instance-profile}"
  role = "${aws_iam_role.managedRole.name}"

  depends_on = [
    "aws_iam_role.managedRole"
  ]
}