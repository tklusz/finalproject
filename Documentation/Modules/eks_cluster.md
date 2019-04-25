# EKS Cluster Module
This is a module used to create an EKS cluster.

Official Terraform documentation for EKS clusters [here.](https://www.terraform.io/docs/providers/aws/r/eks_cluster.html)

## Variables
* **cluster_name** - Name of the cluster.
* **role_arn** - ARN of IAM role created with policy attachment.
* **security_group_id** - ID of the security group to associate with the cluster.
 **subnet_ids** - List of subnets to associate with the EKS cluster. Generally, we will use private subnets unless load balancing is required. You are only allowed to specify public or private subnets, not both.

## Resource creation
The module creates the following resources:
* EKS Cluster.

## Static content and assumptions
* No assumptions or static content currently.

## Output
* No output currently.

## Concerns
* No concerns currently.
