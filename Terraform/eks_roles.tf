# Creating EKS role with assume role policy
module "eks_role" {
  source = "./modules/iam/role"

  role_name = "eks_role"
  role_filepath = "external_docs/iam_policies/eks_policy.json"
}

# Attaching additional premade policies to the role.
module "eks_policies"{
    source = "./modules/iam/role_policy_attachment"

    role_name = "${module.eks_role.role_name}"
    policy_arn_list = [
      "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
      "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
    ]
}
