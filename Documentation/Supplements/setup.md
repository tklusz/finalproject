# Infrastructure setup instructions.
This file contains information on how to set up our infrastructure, laid out in the design document. Note that this file will be changed over time, as our infrastructure changes.

## Required Software
* [AWS CLI](https://aws.amazon.com/cli/)
* [Terraform](https://www.terraform.io/)
* [Docker](https://docs.docker.com/v17.12/install/)
* [kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
* [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
* You also require an AWS account.
* Python 2.7 + boto3.
* Note: This setup is intended for Linux distributions.

## Installation

#### Installation Notes
Most of the deployment is done using Python. It's possible to use the scripts in a CI-CD pipeline, or use configuration management such as Ansible for configuration. Python was used to gain more experience.

The Python scripts are modular, and should work independently as long as equivalent configuration was completed. For example, `kube-update.py` may be used as-is while `kube-image.py` may be replaced with a bash script. Note that all 3 Python scripts depend on the Terraform output being available.

It is also possible to create a separate dockerfile to install all required software, build the infrastructure, and deploy.

#### Prerequisites
* First, install all of the required software.
* Install boto3 with `pip install boto3`. This requires python and python-pip.
* Open a terminal, navigate to the location you would like to install the various infrastructure files.
* Run the command `git clone https://github.com/tklusz/finalproject`.
    * This should download a folder with the finalproject infrastructure code inside.

#### Building Infrastructure
* Navigate inside the new finalproject folder, then to `Terraform`.
* Edit the `terraform.tfvars` file and include your IP address for the `user_ip` variable.
* Run the command `aws configure` and enter your AWS credentials.
* Run the command `terraform init`, then `terraform apply`.
    * If done correctly, Terraform will ask if you want to build a number of resources. Type "yes" and press enter.
    * If the build was successful, a message such as `Apply complete! Resources: x added.` should appear in green in the console.

#### Configuration and Deployment
* Navigate to `finalproject/Scripts/` and run `python kube-update.py`. This will update your EKS cluster with the kubeconfig you generated.
* Navigate to `finalproject/Docker/` and run `sudo python docker.py`. This will build your docker image and upload to ECR (a container registry on AWS).   
* Navigate to `finalproject/Scripts/` and run `python kube-image.py`. This will use the image from ECR to create a container on a node, create a load balancer on AWS, and allocate an external IP address.
* If there are no errors, your infrastructure should be built on your AWS account. You can navigate to the AWS console to see if your infrastructure has been correctly built.

* To visit the site, run `kubectl get services -o wide`, and connect to the public IP address allocated to the `website` service.

## Deleting your infrastructure (automatically).
**You must delete your infrastructure manually if you deleted your .terraform or .tfstate files.**

There are four steps to deleting your infrastructure.

###### Delete the Load Balancer created by kubectl.
*  Navigate to `finalproject/Scripts/` and run `sudo python cleanup.py 1`. This will delete the Load Balancer created by `kube-image.py`. (This isn't necessary if you haven't ran `kube-image.py`).

###### Delete the majority of Terraform infrastructure.
* Navigate to `finalproject/Terraform` and run `terraform destroy`. The console should list a number of resources, and ask if you want to delete them. Type "yes". The majority of your infrastructure will be deleted.
* This may take around 10-15 minutes.
* There will be an error regarding VPC deletion, this is normal.

###### Delete the Load Balancer security group created by kubectl.
*  Navigate to `finalproject/Scripts/` and run `sudo python cleanup.py 2`. This will delete the Load Balancer security group created by `kube-image.py`.

###### Delete the VPC.
* Navigate to `finalproject/Terraform` and run `terraform destroy` again. If the message:
```
module.vpc.aws_vpc.vpc_module_vpc: Destruction complete after 0s
```
 appears, the infrastructure has been deleted (should appear before any error messages). There may be
 ```
 ... is nil, but no error was reported.
 ```
errors which can be ignored.
* Delete the `.terraform`, `terraform.tfstate` and `terraform.tfstate.backup` files in the `finalproject/Terraform` directory.
* The infrastructure deletion process is now complete, and it may now be built again.

## Deleting your infrastructure (manually).

Navigate to the AWS console. This infrastructure uses the following AWS services which must be manually removed:
* EKS - Cluster.
* IAM - Roles, policies, users, groups.
* VPC - VPC (internet gateway, nat gateway, etc).
* EC2 - EKS worker nodes. Should be deleted when the cluster is deleted. Security groups, autoscaling group and a Load Balancer.
