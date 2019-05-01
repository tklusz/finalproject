# Instance Profile Module
This is a module used to create an instance profile.

Official Terraform documentation for instance profiles [here.](https://www.terraform.io/docs/providers/aws/r/iam_instance_profile.html)

## Variables
* **name** - Name of the instance profile.
* **role** - Role to attach to the instance profile.

## Resource creation
The module creates the following resources:
* IAM instance profile.

## Static content and assumptions
* No assumptions or static content currently.

## Output
The module outputs the following:
* Name of the instance profile - `profile_name`.

## Concerns
* No concerns currently.
