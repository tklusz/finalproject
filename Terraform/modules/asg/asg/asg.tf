# Capacity variables.
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}

# Launch config and other information.
variable "launch_configuration" {}
variable "name" {}
variable "vpc_zone_ids" {
  type = "list"
}

# Tag key and value.
variable "tag_key" {
  default = ""
}
variable "tag_value" {
  default = ""
}

# Creating the ASG.
resource "aws_autoscaling_group" "asg_module_asg" {
  desired_capacity = "${var.desired_capacity}"
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"

  launch_configuration = "${var.launch_configuration}"
  name = "${var.name}"
  vpc_zone_identifier = ["${var.vpc_zone_ids}"]

  tag {
    key = "Name"
    value = "${var.name}"
    propagate_at_launch = true
  }

  tag {
    key = "${var.tag_key}"
    value = "${var.tag_value}"
    propagate_at_launch = true
  }

}
