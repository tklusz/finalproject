# EKS Cluster
# Creating the EKS security group.
module "cluster_sg" {
  source = "./modules/security_groups/security_group"

  sg_name = "cluster_sg"
  sg_description = "Allows for communication with worker nodes."
  vpc_id = "${module.vpc.vpc_id}"

  egress_from_ports  = [0]
  egress_to_ports    = [0]
  egress_protocols   = ["-1"]
  egress_cidrs       = [["0.0.0.0/0"]]

  # User's IP address. Set in terraform.tfvars
  ingress_from_ports = [0]
  ingress_to_ports = [0]
  ingress_protocols = ["-1"]
  ingress_cidrs = [["${var.user_ip}/32"]]

  tag_name = "Cluster_SG"
}

# Allows communication between cluster and nodes - on cluster sg.
module "cluster_node_ingress_rule" {
  source = "./modules/security_groups/security_group_rule"

  # Variables for networking.
  from_port = 443
  to_port =  443
  protocol = "tcp"
  type = "ingress"

  # Specify the security group connection.
  source_sg_id = "${module.worker_sg.security_group_id}"
  attach_sg_id = "${module.cluster_sg.security_group_id}"
}


# EKS nodes.
# Creating worker node security group.
module "worker_sg" {
  source = "./modules/security_groups/security_group"

  sg_name = "worker"
  sg_description = "Allows for communication with master cluster and other nodes."
  vpc_id = "${module.vpc.vpc_id}"

  egress_from_ports  = [0]
  egress_to_ports    = [0]
  egress_protocols   = ["-1"]
  egress_cidrs       = [["0.0.0.0/0"]]

  tag_name = "Worker_SG"
}

# Allows communication between worker nodes.
module "worker_self_ingress_rule" {
  source = "./modules/security_groups/security_group_rule"

  # Variables for networking.
  from_port = 0
  to_port =  65535
  protocol = "-1"
  type = "ingress"

  # Specify the security group connection.
  source_sg_id = "${module.worker_sg.security_group_id}"
  attach_sg_id = "${module.worker_sg.security_group_id}"
}

# Allows communication between cluster and nodes - on node sg.
module "worker_node_ingress_rule" {
  source = "./modules/security_groups/security_group_rule"

  # Variables for networking.
  from_port = 1025
  to_port =  65535
  protocol = "tcp"
  type = "ingress"

  # Specify the security group connection.
  source_sg_id = "${module.cluster_sg.security_group_id}"
  attach_sg_id = "${module.worker_sg.security_group_id}"
}
