# Name of the Security Group (as a tag).
variable "tag_name" {}

# Creating the security group using the given variables.
resource "aws_security_group" "sg_module_sg" {
  name = "${var.sg_name}"
  description = "${var.sg_description}"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.tag_name}"
  }
}

# Creates an ingress rule for each item in the ingress lists supplied.
resource "aws_security_group_rule" "autogen_ingress_rules"{
  count = "${length(var.ingress_from_ports)}"

  type = "ingress"
  from_port = "${var.ingress_from_ports[count.index]}"
  to_port = "${var.ingress_to_ports[count.index]}"
  protocol = "${var.ingress_protocols[count.index]}"
  cidr_blocks = ["${var.ingress_cidrs[count.index]}"]

  security_group_id = "${aws_security_group.sg_module_sg.id}"
}

# Creates an egress rule for each item in the egresss lists supplied
resource "aws_security_group_rule" "autogen_egress_rules" {
  count = "${length(var.egress_from_ports)}"

  type = "egress"
  from_port = "${var.egress_from_ports[count.index]}"
  to_port = "${var.egress_to_ports[count.index]}"
  protocol = "${var.egress_protocols[count.index]}"
  cidr_blocks = ["${var.egress_cidrs[count.index]}"]

  security_group_id = "${aws_security_group.sg_module_sg.id}"
}

output "security_group_id" {
  value = "${aws_security_group.sg_module_sg.id}"
}
