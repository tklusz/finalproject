# Using our template file.
data "template_file" "cluster_file" {
	template = "${file("external_docs/iam_policies/cluster_policy.json.tpl")}"

	vars {
    user_arn = "${module.eks_admin.user_arn}"
	}
}

# Creating EKS role with assume role policy. Used for cluster.
module "cluster_role" {
  source = "./modules/iam/role"

  role_name = "cluster_role"
  role_template = "${data.template_file.cluster_file.rendered}"
  role_path = "/eks/"
}

# Attaching additional premade policies to the role. Used for cluster.
module "eks_policies"{
    source = "./modules/iam/role_policy_attachment"

    role_name = "${module.cluster_role.role_name}"
    policy_arn_list = [
      "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
      "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
    ]
}

# Using template file for worker nodes.
data "template_file" "worker_file" {
		template = "${file("external_docs/iam_policies/worker_policy.json.tpl")}"
}

# Creating worker node role
module "worker_role" {
	source = "./modules/iam/role"

	role_name = "worker_role"
	role_template = "${data.template_file.worker_file.rendered}"
}

# Attaching policies to the role.
module "worker_policies"{
	source = "./modules/iam/role_policy_attachment"

	role_name = "${module.worker_role.role_name}"
	policy_arn_list = [
		"arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
		"arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
		"arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
	]
}

# Creating instance profile for the worker node role.
module "worker_instance_profile" {
	source = "./modules/iam/instance_profile"

	name = "worker_instance_profile"
	role = "${module.worker_role.role_name}"
}
