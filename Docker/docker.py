# Requires Boto3 - pip install boto3
# Must run "aws configure" before running this script.
# Terraform must successfully be built before running this script.

# Run kube-update.py prior to running this script.

# Using subprocess and os for system commands.
import subprocess
import os

# Get the ECR repository URL.
def get_repository():
    # Spinning up a process to retrieve the ECR repository URL from Terraform output
    process = subprocess.Popen(["terraform", "output", "-state=../Terraform/terraform.tfstate","registry_url"], stdout=subprocess.PIPE)

    # Outputting the URL from the process, stripping new line, making a string.
    return str(process.stdout.read().rstrip())

# Creating our docker image.
def create_docker_image(url):

    # Building the image.
    subprocess.call("docker build -t " + url + ":latest .", shell=True)


# Uploading our docker image
def upload_image(url):

    # Logging into AWS to push to the repository.
    os.system("$(aws ecr get-login --no-include-email --region us-west-2)")

    # Pushing to repository.
    os.system("docker push " + url)

# Retrieving name, pulling kubectl, updating config map.
try:
    url = get_repository()
    create_docker_image(url)
    upload_image(url)

    print("\nBuild Successful. Run 'kubectl get nodes --watch' to view nodes.")

# Handling errors.
except Exception as e:
    print("Build Unsuccessful. Common errors:")
    print("\tEnsure boto3 and aws cli are installed.")
    print("\tEnsure your Terraform has already been succesfuly built.")
    print("\tEnsure `aws configure` has already been ran.")
    print("\tEnsure kube-update.py has alreday been ran.")
    print("Error message:")
    print(e)
