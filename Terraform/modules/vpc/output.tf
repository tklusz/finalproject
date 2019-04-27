# Outputs ID of the VPC
output "vpc_id" {
  value = "${aws_vpc.vpc_module_vpc.id}"
}

# Outputs the public subnet ids
output "public_subnet_ids"{
  value = "${aws_subnet.vpc_module_public_subnet.*.id}"
}

# Outputs the private subnet ids
output "private_subnet_ids"{
  value = "${aws_subnet.vpc_module_private_subnet.*.id}"
}
