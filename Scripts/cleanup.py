# Run this file when deleting infrastructure.

# Using os for system commands, boto3.
import os, boto3, sys

# Delete website service.
def kube_cleanup():
    os.system("kubectl delete service website")

# Delete ELB security group
def del_sg():
    # Using boto3 to get ELB security group.
    ec2 = boto3.client("ec2")
    response = ec2.describe_security_groups(
        Filters=[
          {
            'Name': 'tag-key',
            'Values': [
                'kubernetes.io/cluster/eks_master_cluster',
            ]
          }
        ]
    )

    # Deleting the ELB security group
    ec2.delete_security_group(
        GroupId = response["SecurityGroups"][0]["GroupId"]
    )


# Deleting infrastructure.
if(sys.argv[1] == "1"):
    kube_cleanup()
elif(sys.argv[1] == "2"):
    del_sg()
