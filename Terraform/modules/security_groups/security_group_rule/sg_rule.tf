# Variables for networking.
variable "from_port" {}
variable "to_port" {}
variable "protocol" {}
variable "type" {}

# Specify the security group connection.
variable "source_sg_id" {}
variable "attach_sg_id" {}

# Creating the rule.
resource "aws_security_group_rule" "sg_rule_module_rule" {
  from_port = "${var.from_port}"
  to_port = "${var.to_port}"
  protocol = "${var.protocol}"
  type = "${var.type}"

  security_group_id = "${var.attach_sg_id}"
  source_security_group_id = "${var.source_sg_id}"
}
