# Variables used to create the IAM role.
variable "role_name" {}
variable "role_filepath" {}

# Create the IAM role.
resource "aws_iam_role" "role_module_role" {
	name = "${var.role_name}"
	assume_role_policy = "${file("${var.role_filepath}")}"
}

# Output role name and ARN.
output "role_name" {
	value = "${aws_iam_role.role_module_role.name}"
}
output "role_arn" {
	value = "${aws_iam_role.role_module_role.arn}"
}
