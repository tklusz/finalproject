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

# Outputs
output "cluster_endpoint" {
  value = "${aws_eks_cluster.eks_module_cluster.endpoint}"
}

output "cluster_authority" {
  value = "${aws_eks_cluster.eks_module_cluster.certificate_authority.0.data}"
}

output "cluster_name" {
  value = "${var.cluster_name}"
}
