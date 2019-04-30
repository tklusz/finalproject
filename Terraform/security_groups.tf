# Creating the EKS security group.
module "eks_sg" {
  source = "./modules/security_group"

  sg_name = "eks"
  sg_description = "Allows for communication with worker nodes."
  vpc_id = "${module.vpc.vpc_id}"

  egress_from_ports  = [0]
  egress_to_ports    = [0]
  egress_protocols   = ["-1"]
  egress_cidrs       = [["0.0.0.0/0"]]

  /*
  If you would like to access with your local machine, uncomment the following.
  Remember to comment again before uploading to github.


  ingress_from_ports = [0]
  ingress_to_ports = [0]
  ingress_protocols = ["-1"]
  ingress_cidrs = [["x.x.x.x/32"]]

  */


  tag_name = "EKS_SG"
}
