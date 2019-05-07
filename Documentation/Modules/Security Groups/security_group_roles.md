# Security Group Rule Module
This is a module used to create a security group rule. Used in conjunction with the security_group module, when networking using security groups is required.

Official Terraform documentation for security group rules [here.](https://www.terraform.io/docs/providers/aws/r/security_group_rule.html)

## Variables
* **from_port** - Start port. Specifies start of a range of ports to allow communication.
* **to_port** - End port where traffic is allowed to come thorough
* **protocol** - Protocol used to communicate on the port range.
* **type** - Ingress or egress (inbound our outbound traffic).
* **source_sg_id** - Source security group ID where traffic comes from/goes to. This is the reason why this module exists.
* **attach_sg_id*** - Security group to associate this rule with.

## Resource creation
The module creates the following resources:
* A security group rule. Requires a security group already created.

## Static content and assumptions
* No assumptions or static content currently.

## Output
* No outputs currently.

## Concerns
* No concerns currently.
