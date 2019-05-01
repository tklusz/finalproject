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

## Additional information
Using an IAM role in relation to a trust relationship, (for example `Terraform/external_docs/iam_policies/eks_policy.json.tpl`), to add additional IAM accounts, you can use the following formatting:
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com",
        "AWS": [
          "arn:aws:iam::<accountid>:user/<username1>",
          "arn:aws:iam::<accountid>:user/<username2>"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```
It's also possible to use variables, which can be set during the use of the  module.
