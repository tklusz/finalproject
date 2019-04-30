# Using our template role.
data "template_file" "policy_file" {
	template = "${file("external_docs/iam_policies/eks_policy.json.tpl")}"

	vars {
    user_arn = "${module.eks_admin.user_arn}"
	}
}


# Creating EKS role with assume role policy
module "eks_role" {
  source = "./modules/iam/role"

  role_name = "eks_role"
  role_template = "${data.template_file.policy_file.rendered}"
  role_path = "/eks/"
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
