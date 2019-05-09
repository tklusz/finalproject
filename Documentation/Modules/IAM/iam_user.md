# IAM User Module
This is a module used to create an IAM user.

Official Terraform documentation for IAM users [here.](https://www.terraform.io/docs/providers/aws/r/iam_user.html)

## Variables
* **username** - Name of the user.
* **user_path** - Path the user will be placed in. Default = "/"

## Resource creation
The module creates the following resources:
* An IAM user

## Static content and assumptions
* No assumptions or static content currently.

## Output
This module outputs the following
* User's ARN - `user_arn`
* user's name - `user_name`

## Concerns
* No concerns currently.
