# Taking in name and role as variables.
variable "name" {}
variable "role" {}

# Creating the instance profile.
resource "aws_iam_instance_profile" "instance_profile_module_profile" {
  name = "${var.name}"
  role = "${var.role}"
}

# Outputs
output "profile_name" {
  value = "${aws_iam_instance_profile.instance_profile_module_profile.name}"
}
