# Getting EKS optimized AMI to use for our ASG.
data "aws_ami" "node_ami" {
  filter {
    name = "name"
    values = ["amazon-eks-node-${module.eks_cluster.cluster_version}-v*"]
  }
  most_recent = true

  # Amazon's EKS AMI ID
  owners = ["602401143452"]
}

# Setting up a local userdata to simplify encoding.
# More information here - https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html
locals {
  node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${module.eks_cluster.cluster_endpoint}' --b64-cluster-ca '${module.eks_cluster.cluster_authority}' '${module.eks_cluster.cluster_name}'
USERDATA
}

# Launch configuration for our ASG.
module "node_launch_config" {
  source = "./modules/asg/launch_config"

  instance_profile = "${module.worker_instance_profile.profile_name}"
  image_id = "${data.aws_ami.node_ami.id}"
  instance_type = "t2.micro"

  prefix = "eks_master_node"
  userdata_b64 = "${base64encode(local.node-userdata)}"
  sg_list = ["${module.worker_sg.security_group_id}"]

}


# Creating the ASG
module "node_asg" {
  source = "./modules/asg/asg"

  desired_capacity = 2
  max_size = 2
  min_size = 1

  launch_configuration = "${module.node_launch_config.lc_id}"
  name = "eks_node_asg"

  vpc_zone_ids = ["${module.vpc.private_subnet_ids}"]

  tag_key = "kubernetes.io/cluster/${module.eks_cluster.cluster_name}"
  tag_value = "owned"

}
