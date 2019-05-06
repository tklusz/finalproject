# Must run "aws configure" before running this script.
# Terraform must successfully be built before running this script.

# Run kube-update.py and docker.py prior to running this script.

# Using os, subprocess for system commands.
import os, subprocess

# Get the ECR repository URL.
def get_repository():
    # Spinning up a process to retrieve the ECR repository URL from Terraform output
    process = subprocess.Popen(["terraform", "output", "-state=../Terraform/terraform.tfstate","registry_url"], stdout=subprocess.PIPE)

    # Outputting the URL from the process, stripping new line, making a string.
    return str(process.stdout.read().rstrip())

# Creating an instance of the ECR container image, then exposing and allocating a public IP.
# This will also create a load balancer on AWS.
def update_image(url):

    # Pulling ECR image, running a new srvice with the image.
    os.system("kubectl run website --image=" + url + ":latest --port 80")
    os.system("kubectl expose deployment website --type=LoadBalancer --port=80 --target-port=80")


# Retrieving repository, pulling image,
try:
    url = get_repository()
    update_image(url)

    print("\nBuild Successful. Run 'kubectl get services' to view services.\nRun `kubectl describe svc website` to view more information about the service.")
    print("\nConnect to the site using a browser, navigating to the external ip address from the previous commands.")

# Handling errors.
except Exception as e:
    print("Build Unsuccessful. Common errors:")
    print("\tEnsure boto3 and aws cli are installed.")
    print("\tEnsure your Terraform has already been succesfuly built.")
    print("\tEnsure `aws configure` has already been ran.")
    print("\tEnsure kube-update.py has alreday been ran.")
    print("Error message:")
    print(e)
