# Creating EKS cluster.
# Note - may take around 10 minutes to create.
module "eks_master" {
  source = "./modules/eks/master"

  cluster_name = "eks_master_cluster"
  role_arn = "${module.eks_role.role_arn}"

  security_group_id = "${module.eks_sg.security_group_id}"
  subnet_ids = "${module.vpc.private_subnet_ids}"
}
