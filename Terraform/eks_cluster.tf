# Creating EKS cluster.
# Note - may take around 10 minutes to create.
module "eks_cluster" {
  source = "./modules/eks/cluster"

  cluster_name = "${var.cluster_name}"
  role_arn = "${module.cluster_role.role_arn}"

  security_group_id = "${module.cluster_sg.security_group_id}"
  subnet_ids = "${concat(module.vpc.private_subnet_ids, module.vpc.public_subnet_ids)}"
}

# Creating ECR repository.
module "ecr_repository" {
  source = "./modules/ecr"

  name = "eks_registry"
}

# Outputting the URL. Used by Python.
output "registry_url" {
  value = "${module.ecr_repository.registry_url}"
  sensitive = true
}
