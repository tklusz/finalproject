# Specifying variables
variable "cluster_name"{}
variable "role_arn" {}
variable "security_group_id"{}
variable "subnet_ids"{
  type = "list"
}

# Creating the cluster
resource "aws_eks_cluster" "eks_module_cluster"{
  name = "${var.cluster_name}"
  role_arn = "${var.role_arn}"

  vpc_config {
    security_group_ids = ["${var.security_group_id}"]
    subnet_ids = ["${var.subnet_ids}"]
  }
}
