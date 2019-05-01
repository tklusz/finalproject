# Variables.
# Name of the Security Group
variable "sg_name" {}

# Security Group description.
variable "sg_description" {}

# ID of the VPC
variable "vpc_id" {}

# The following varibles are described in the comment.tf file.
variable "ingress_from_ports" {
  type = "list"
  default = []
}
variable "ingress_to_ports" {
  type = "list"
  default = []
}
variable "ingress_protocols" {
  type = "list"
  default = []
}
variable "ingress_cidrs" {
  type = "list"
  default = []
}

variable "egress_from_ports" {
  type = "list"
  default = []
}
variable "egress_to_ports" {
  type = "list"
  default = []
}
variable "egress_protocols" {
  type = "list"
  default = []
}
variable "egress_cidrs" {
  type = "list"
  default = []
}
