# Requires Boto3 - pip install boto3
# Must run "aws configure" before running this script.

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

# Retrieves the kubectl configuration, places in .kube/config
def retrieve_kubectl(cluster_name):
    command = "aws eks update-kubeconfig --name " + cluster_name

    os.system(command)

# Retrieving name then pulling kubectl.
try:
    cluster_name = retrieve_name()
    retrieve_kubectl(cluster_name)

# Handling errors.
except Exception as e:
    print("Build Unsuccessful. Common errors:")
    print("\tEnsure boto3 and aws cli are installed.")
    print("\tEnsure your Terraform has already been succesfuly built.")
    print("\tEnsure `aws configure` has already been ran.")
    print("Error message:")
    print(e)
