# Role Policy Attachment Module
This is a module used to create multiple role-policy attachments easily..

Official Terraform documentation for role-policy-attachments [here.](https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html)

## Variables
* **role_name** - Name of role. Must have been previously created.
* **policy_arn_list** - List of policy ARNs in string format.

## Resource creation
The module doesn't create any resources, but attaches each of the specified policy ARNs to the role specified. This is useful as it saves 3 lines for each policy attached (above 1), compared to using resources for the same effect. The module makes it much simpler to add multiple policies to a role.

## Static content and assumptions
* No assumptions or static content currently.

## Output
* No outputs currently.

## Concerns
* No concerns currently.
