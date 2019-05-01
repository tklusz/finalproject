# Requires Boto3 - pip install boto3
# Must run "aws configure" before running this script.
# Terraform must successfully be built before running this script.

# Using boto3; os for system commands.
import boto3
import os

# Retrieving our cluster name (this should be updated with a tag if you're using multiple clusters).
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

# Sets up config map.
def config_map_setup():

    # Create config map from output
    os.system("terraform output -state=../Terraform/terraform.tfstate config_map_aws_auth > config_map_aws_auth.yaml")

    # Apply new configmap
    os.system("kubectl apply -f config_map_aws_auth.yaml")

    # Deletes local copy of config map.
    os.system("rm config_map_aws_auth.yaml")


# Retrieving name, pulling kubectl, updating config map.
try:
    cluster_name = retrieve_name()
    retrieve_kubectl(cluster_name)
    config_map_setup()

    print("\nBuild Successful. Run 'kubectl get nodes --watch' to view nodes.")

# Handling errors.
except Exception as e:
    print("Build Unsuccessful. Common errors:")
    print("\tEnsure boto3 and aws cli are installed.")
    print("\tEnsure your Terraform has already been succesfuly built.")
    print("\tEnsure `aws configure` has already been ran.")
    print("Error message:")
    print(e)
