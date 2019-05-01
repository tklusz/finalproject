# Launch Configuration Module
This is a module used to create a launch configuration, used in autoscaling groups.

Official Terraform documentation for launch configurations [here.](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html)

## Variables
* **instance_profile** - Instance profile associated with the instances that are created.
* **image_id** - Images the EC2 instances will used.
* **instance_type** - Type of instance to use (e.g. t2.micro, m4.large)
* **prefix** - Prefix used in naming the instances. All created instances will start with this prefix.
* **userdata_b64** - Userdata script in base64. Will run when the instance starts.
* **sg_list** - List of security groups to associate with the instances that are created.

## Resource creation
The module creates the following resources:
* A launch configuration used in ASGs.

## Static content and assumptions
* Instance profile is required.
* Always associating a public IP address.
* Create_before_destroy = true.

## Output
This module outputs the following:
* ID of the launch configuration - `lc_id`.

## Concerns
* No concerns currently.
