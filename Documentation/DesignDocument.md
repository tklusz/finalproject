# FinalProject Design Document.
This is our design document for our final CIT 481 project.

## Authors
* Tyler Kluszczynski
* Aubrey Nigoza
* Hayden Wilcox

## Overview
For this project, we plan to create a relatively simple Terraform + AWS EKS Kubernetes deployment that can be scaled up. We were given 15 days to complete as much of our deployment plan as possible.

## Goals and Milestones
* Complete Terraform code required for EKS deployment.
* Set up Kubernetes cluster with EKS.
* Set up Kubernetes deployment configuration.
* Create Dockerfile for building the image used in our EKS deployment. This will include our application (static website or Wordpress), and possibly a monitoring solution, depending on time constraints.
* Utilize kubectl with EKS to manage the Kubernetes cluster.


## Service Breakdown
This section contains a breakdown of each service, and how it will be used to create our infrastructure. Note that this section is tentative and may change as our infrastructure progresses, or we decide on different implementations.

#### Terraform
Terraform will be used to create an EKS cluster, VPC with networking, IAM roles, instance profiles, and Security groups. We will also create an ASG with launch configuration if time allows.

#### Ansible, Bash
We will use Ansible or Bash to configure our instances, installing required software for our deployments.

#### AWS CLI
AWS CLI will be used to update our kubectl. This can be ran during a CI-CD pipeline or during deployment, depending on time constraints.

## Resources and Credits
We utilized the following web resources to aid in creation of our infrastructure. This section will be updated periodically throughout the creation of our infrastructure.

* CloudCraft - Allows for creation of infrastructure images.
    * [Site.](https://cloudcraft.co/)
* freeCodeCamp - Article that provided design document tips.
    * [Site.](https://medium.freecodecamp.org/how-to-write-a-good-software-design-document-66fcf019569c)
* terraform.io - Documentation for terraform resources.
    * [Site.](https://www.terraform.io/docs/)
    * [EKS introduction.](https://learn.hashicorp.com/terraform/aws/eks-intro)
* kubernetes.io - Kubernetes documentation and tutorial.
    * [Site.](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
