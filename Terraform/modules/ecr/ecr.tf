# Name of the repository.
variable "name" {}

# Creating the ECR
resource "aws_ecr_repository" "ecr_module_repository" {
    name = "${var.name}"
}

# Outputting the registry url.
output "registry_url" {
  value = "${aws_ecr_repository.ecr_module_repository.repository_url}"
}
