# Variables required for our AWS VPC module.

# For VPC itself.
variable "cidr_block" {}
variable "instance_tenancy" {}
variable "cluster_name" {}

# For subnets.
variable "private_subnet_cidrs" {
  type = "list"
  default = []
}
variable "private_subnet_azs" {
  type = "list"
  default = []
}

variable "public_subnet_cidrs" {
  type = "list"
  default = []
}
variable "public_subnet_azs" {
  type = "list"
  default = []
}
