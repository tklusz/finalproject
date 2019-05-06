# Creating the VPC itself.
resource "aws_vpc" "vpc_module_vpc" {
  cidr_block = "${var.cidr_block}"
  instance_tenancy = "${var.instance_tenancy}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = "${
    map(
     "Name", "vpc_module_vpc",
     "kubernetes.io/cluster/${var.cluster_name}", "owned",
    )
  }"
}

# Creating an internet gateway.
resource "aws_internet_gateway" "vpc_module_ig" {
  vpc_id = "${aws_vpc.vpc_module_vpc.id}"
}

# Generates our private subnets.
resource "aws_subnet" "vpc_module_private_subnet" {

  /*
    Count tells Terraform to repeat this creation a number of times.
    Using a length function to determine the length of our CIDR list.
    We are creating 1 subnet per item in the CIDR list, so this is how many times
    We repeat the creation.
  */
  count = "${length(var.private_subnet_cidrs)}"

  # Using the VPC we created eariler.
  vpc_id = "${aws_vpc.vpc_module_vpc.id}"

  # This is the CIDR given as a variable, getting whichever CIDR is at the
  # current index.
  cidr_block = "${var.private_subnet_cidrs[count.index]}"

  # Availiability zones are also supplied as a list, using the same process as
  # cidr_block to obtain each value in the list as we loop through creation.
  availability_zone = "${var.private_subnet_azs[count.index]}"

  # Also tagging our subnets using the current index.
  # If we have 2 subnets they  will be tagged "Private_0" & "Private_1"
  tags = "${
    map(
     "Name", "Private_${count.index}",
     "kubernetes.io/cluster/${var.cluster_name}", "owned",
    )
  }"
}

# Generates our public subnets, nearly identical code to private subnets.
resource "aws_subnet" "vpc_module_public_subnet" {
  count = "${length(var.public_subnet_cidrs)}"
  vpc_id = "${aws_vpc.vpc_module_vpc.id}"
  cidr_block = "${var.public_subnet_cidrs[count.index]}"
  availability_zone = "${var.public_subnet_azs[count.index]}"

  tags = "${
    map(
     "Name", "Public_${count.index}",
     "kubernetes.io/cluster/${var.cluster_name}", "owned",
    )
  }"
}

# Creating our private route table.
resource "aws_route_table" "vpc_module_private_rt"{
  vpc_id = "${aws_vpc.vpc_module_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.vpc_module_nat.id}"
  }

  tags{
    Name = "vpc-module-private-route-table"
  }
}

# Creating our public route table.
resource "aws_route_table" "vpc_module_public_rt"{

  vpc_id = "${aws_vpc.vpc_module_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_module_ig.id}"
  }
  tags{
    Name = "vpc-module-public-route-table"
  }
}

# Route table associations for public and private subnets.
resource "aws_route_table_association" "vpc_module_public_rta" {
  count          = "${length(var.public_subnet_cidrs)}"

  subnet_id      = "${element(aws_subnet.vpc_module_public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.vpc_module_public_rt.id}"
}

resource "aws_route_table_association" "vpc_module_private_rta" {
  count           = "${length(var.private_subnet_cidrs)}"

  subnet_id       = "${element(aws_subnet.vpc_module_private_subnet.*.id, count.index)}"
  route_table_id  = "${aws_route_table.vpc_module_private_rt.id}"
}


# Creating an elastic IP, used for our NAT gateway.
resource "aws_eip" "vpc_module_eip"{
  vpc = "true"
}

# Creating our NAT gateway
resource "aws_nat_gateway" "vpc_module_nat" {
  allocation_id = "${aws_eip.vpc_module_eip.id}"
  subnet_id = "${element(aws_subnet.vpc_module_public_subnet.*.id, 0)}"

}
