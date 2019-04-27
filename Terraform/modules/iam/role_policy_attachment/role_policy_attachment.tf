# Variables used in creation.
variable "role_name" {}
variable "policy_arn_list" {
  type = "list"
  default = []
}

# Attaching each policy to the role.
resource "aws_iam_role_policy_attachment" "module_rpa_attachment"{
  count = "${length(var.policy_arn_list)}"

  policy_arn = "${var.policy_arn_list[count.index]}"
  role = "${var.role_name}"
}
