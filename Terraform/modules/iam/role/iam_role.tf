# Variables used to create the IAM role.
variable "role_name" {}
variable "role_template" {}
variable "role_path" {
	default = "/"
}

# Create the IAM role.
resource "aws_iam_role" "role_module_role" {
	name = "${var.role_name}"
	assume_role_policy = "${var.role_template}"
	path = "${var.role_path}"
}

# Output role name and ARN.
output "role_name" {
	value = "${aws_iam_role.role_module_role.name}"
}
output "role_arn" {
	value = "${aws_iam_role.role_module_role.arn}"
}
