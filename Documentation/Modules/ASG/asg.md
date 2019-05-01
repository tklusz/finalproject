# ASG Module
This is a module used to create an autoscaling group.

Official Terraform documentation for autoscaling groups [here.](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html)

## Variables
* **desired_capacity** - Desired capacity of the ASG.
* **max_size** - Maximum number of instances to create.
* **min_size** - Minimum number of instances to have running.
* **launch_configuration** - Launch configuration for the instances.
* **name** - Name of the ASG.
* **vpc_zone_ids** - List of VPCs to place the ASG instances in.
* **tag_key** - Tag key that can be set. Default is blank.
* **tag_value** - Tag value that can be set. Default is blank.

## Resource creation
The module creates the following resources:
* An autoscaling group.

## Static content and assumptions
This module has the following static content:
* propagate_at_launch for tags is always true.

## Output
* No outputs currently.

## Concerns
* No concerns currently.
