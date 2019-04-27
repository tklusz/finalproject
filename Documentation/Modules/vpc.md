# VPC Module
This is a module used to create a VPC with other associated resources.

Official Terraform documentation for VPCs appears [here.](https://www.terraform.io/docs/providers/aws/r/vpc.html)

## Variables
* **cidr_block** - CIDR block used in creation of the VPC.
* **instance_tenancy** - Shared vs dedicated hardware.
* **private_subnet_cidrs** - CIDR blocks of private subnets.
* **public_subnet_cidrs** - CIDR blocks of public subnets.
* **private_subnet_azs** - AZs for the private subnets.
* **public_subnet_azs** - AZs for the public subnets.

## Resource creation
The module creates the following resources:
* VPC
* Internet gateway
* Private and public subnets
* Private and public route tables with routes
* Route table association for private and public subnets
* Elastic IP
* NAT gateway

## Static content and assumptions
* All resources above will be created.
* VPC support for DNS and hostnames = true.
* Route will always point to IG and NAT gateway.

## Output
* VPC id - `vpc_id`
* Private subnet ids (as a list) - `private_subnet_ids`
* Public subnet ids (as a list) - `public_subnet_ids`

## Concerns
* No concerns currently.
