# Policy and Group Module
This is a module used to create a group, attach a policy and users to it.

Official Terraform documentation for groups [here.](https://www.terraform.io/docs/providers/aws/r/iam_group.html)

## Variables
* **group_name** - Name for the group (this shows up on AWS).
* **policy_arn** - Policy ARN that will be attached to the group.
* **user_list** - List of user's names to add to the group.


## Resource creation
The module creates the following resources:
* IAM group.
* IAM group policy attachment.
* IAM group membership.

## Static content and assumptions
* No assumptions or static content currently.

## Output
* No outputs currently.

## Concerns
* No concerns currently.
