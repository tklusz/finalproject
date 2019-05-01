# Name for the group (this shows up on AWS).
variable "group_name" {}

# Policy ARN that will be attached to the group.
variable "policy_arn" {}

# List of usernames to add to the group.
variable "user_list" {
  type = "list"
}

# Creating the group
resource "aws_iam_group" "policy_and_group_group" {
  name = "${var.group_name}"
}

# Utilizing the policy specified.
data "aws_iam_policy" "policy_and_group_policy" {
  arn = "${var.policy_arn}"
}

# Attaching the group and policy.
resource "aws_iam_group_policy_attachment" "policy_and_group_attachment"{
  group = "${aws_iam_group.policy_and_group_group.name}"
  policy_arn = "${data.aws_iam_policy.policy_and_group_policy.arn}"
}

# Attaching users to the group.
resource "aws_iam_group_membership" "policy_and_group_membership"{
  name  = "${var.group_name}"
  users = ["${var.user_list}"]
  group = "${aws_iam_group.policy_and_group_group.name}"
}
