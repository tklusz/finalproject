# Variables for the launch configuration.
variable "instance_profile" {}
variable "image_id" {}
variable "instance_type" {}

variable "prefix" {}
variable "userdata_b64" {}
variable "sg_list" {
  type = "list"
}

# Creating the launch config.
resource "aws_launch_configuration" "launch_config_module_lc" {
  associate_public_ip_address = true
  iam_instance_profile = "${var.instance_profile}"
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  name_prefix = "${var.prefix}"
  user_data_base64 = "${var.userdata_b64}"
  security_groups = ["${var.sg_list}"]

  lifecycle {
    create_before_destroy = true
  }
}

# Outputs
output "lc_id" {
  value = "${aws_launch_configuration.launch_config_module_lc.id}"
}
