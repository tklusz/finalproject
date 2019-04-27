# Security Group Module
This is a module used to create security groups.

Official Terraform documentation for security groups [here.](https://www.terraform.io/docs/providers/aws/r/security_group.html)

## Variables
* **sg_name** - Name of the security group.
* **sg_description** - Description of the security group.
* **vpc_id** - ID of the VPC.
* **egress/ingress_from_ports** - List of egress/ingress ports "from".
* **egress/ingress_to_ports** - List of egress/ingress ports "to".
* **egress/ingress_protocols** - List of egress/ingress protocol to use.
* **egress/ingress_cidrs** - List of egress/ingress CIDRs.
* **tag_name** - Name of the security group. Set in a tag.

## Resource creation
The module creates the following resources:
* A single security group

## Static content and assumptions
* No assumptions or static content currently.

## Output
* ID of the security group - `security_group_id`

## Concerns
* Formatting is a bit strange for this module. See the large comment in the file for more information about how to use the variables correctly.
