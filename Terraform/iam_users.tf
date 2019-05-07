# NOTE - Passwords must be manually created for users.

# Creating admin for EKS.
module "eks_admin" {
  source = "./modules/iam/user"
  username = "eks_admin"
}

# Adding administrator permissions to EKS admin.
module "admin_permissions" {
  source = "./modules/iam/policy_and_group"

  group_name = "administrators"
  user_list = ["${module.eks_admin.user_name}"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
