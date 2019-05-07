# Variables used in creation
variable "username" {}
variable "user_path" {
  default = "/"
}

# Creating the IAM user.
resource "aws_iam_user" "iam_user_user" {
  name = "${var.username}"
  path = "${var.user_path}"
}

# Outputs
output "user_arn" {
  value = "${aws_iam_user.iam_user_user.arn}"
}
output "user_name" {
  value = "${aws_iam_user.iam_user_user.name}"
}
