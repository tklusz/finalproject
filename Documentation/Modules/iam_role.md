# IAM Role Module
This is a module used to create IAM roles using files.

Official Terraform documentation for IAM roles [here.](https://www.terraform.io/docs/providers/aws/r/iam_role.html)

## Variables
* **role_name** - Name of the IAM role to create.
* **role_filepath** - Path to the IAM role file on the system.
* **role_path** - Path to IAM role. Default = '/'

## Resource creation
The module creates the following resources:
* IAM role with policy attachment.

## Static content and assumptions
* IAM role will have an attached policy.

## Output
This module outputs the following
* Name of the IAM role - `role_name`.
* ARN of the IAM role - `role_arn`.

## Concerns
* None concerns currently.
