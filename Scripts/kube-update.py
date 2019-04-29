# Requires Boto3 - pip install boto3
# Must run "aws configure" before running this script.
# Place kubectl config file in Scripts/kubeconfig

# Using boto3; os for system commands (aws cli).
import boto3
import os

# Retrieving our cluster name.
def retrieve_name():

    client = boto3.client('eks')
    clusters = client.list_clusters(
        maxResults = 1,
    )
    return clusters['clusters'][0]

# Retrieving necessary IAM role ARN for kubectl update.
def retrieve_iam_role():
    client = boto3.client('iam')
    roles = client.list_roles(
        PathPrefix = '/eks/',
        MaxItems = 1
    )
    return roles['Roles'][0]['Arn']

# Retrieves the kubectl configuration, places in .kube/config
def retrieve_kubectl(cluster_name, cluster_iam):
    command = "aws eks update-kubeconfig --name " + cluster_name + \
        " --role-arn " + cluster_iam

    os.system(command)

# Retrieving name, iam role, then pulling kubectl.
try:
    cluster_name = retrieve_name()
    cluster_iam = retrieve_iam_role()

    retrieve_kubectl(cluster_name, cluster_iam)

# Handling errors.
except Exception as e:
    print("Build Unsuccessful. Common errors:")
    print("\tEnsure boto3 and aws cli are installed.")
    print("\tEnsure your Terraform has already been succesfuly built.")
    print("\tEnsure `aws configure` has already been ran.")
    print("Error message:")
    print(e)
