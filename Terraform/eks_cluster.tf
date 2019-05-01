# Creating EKS cluster.
# Note - may take around 10 minutes to create.
module "eks_cluster" {
  source = "./modules/eks/cluster"

  cluster_name = "eks_master_cluster"
  role_arn = "${module.cluster_role.role_arn}"

  security_group_id = "${module.cluster_sg.security_group_id}"
  subnet_ids = "${module.vpc.private_subnet_ids}"
}
