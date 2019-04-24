# Infrastructure setup instructions.
This file contains information on how to set up our infrastructure, laid out in the design document. Note that this file will be changed over time, as our infrastructure changes.

## Required Software
* [AWS CLI](https://aws.amazon.com/cli/)
* [Terraform](https://www.terraform.io/)
* You also require an AWS account.
* Note: This setup is intended for Linux distributions.

## Installation
* First, install the required software.
* Open a terminal, navigate to the location you would like to install the various infrastructure files.
* Run the command `git clone https://github.com/tklusz/finalproject`.
    * This should download a folder with the finalproject infrastructure code inside.
* Navigate inside the new finalproject folder, then to `Terraform`.
* Run the command `aws configure` and enter your AWS credentials.
* Run the command `terraform init`, then `terraform apply`.
    * If done correctly, Terraform will ask if you want to build a number of resources. Type "yes" and press enter.
* If there are no errors, your infrastructure should be built on  your AWS account. You can navigate to the AWS console to see if your infrastructure has been correctly built.

## Deleting your infrastructure (automatically).
**You must delete your infrastructure manually if you deleted your .terraform or .tfstate files.**

Navigate back to your finalproject folder. From there, navigate to the Terraform folder, and type `terraform destroy`. The console should list a number of resources, and ask if you want to delete them. Type "yes". If there are no errors, your infrastructure has been successfully deleted.

## Deleting your infrastructure (manually).
