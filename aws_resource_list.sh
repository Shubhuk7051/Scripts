#!/bin/bash

################################################################

# Author: Shubham Katre
# Version: 0.0.1

# Script to automate the process of listing all the resources in an AWS account.
# 
# Below are the services that are supported by this script.
# 1. EC2
# 2. EBS
# 3. IAM
# 4. Lambda
# 5. S3
# 6. RDS
# 7. VPC
# 8. EKS
#
# The Script will prompt the user to enter the AWS region and the service for which the resources need to be listed.
# 
# Usage: ./aws_resource_list.sh <region> <service_name>
# Example: ./aws_resource_list.sh us-east-1 ec2
##################################################################

# Check if the required number of arguments are passed.
if [ $# -ne 2 ]; then
    echo "Usage: ./aws_resource_list.sh <region> <service_name>"
    echo "Example: ./aws_resource_list.sh us-east-1 ec2"
    exit 1
fi

# Assign the arguments to vaiables and convert the service to lowercase
aws_region= $1
aws_service= $2

# Check if the AWS CLI is installed.
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install the AWS CLI and try again."
    exit 1
fi

# Check if the AWS credentials or AWS CLI are configured.

if [ ! -d ~/.aws ]; then
    echo " AWS CLI is not configured. Please configure the AWS CLI and try again."
    exit 1
fi

# List the resources based on the services.

case $aws_service in
    ec2)
        echo "Listing EC2 instances in $aws_region."
        aws ec2 describe_instances --region $aws_region
        ;;
    rds)
        echo "Listing RDS instances in $aws_region."
        aws rds describe_instances --region $aws_region
        ;;
    s3)
        echo "Listing S3 buckets in $aws_region."
        aws s3 list-buckets --region $aws_region
        ;;
    vpc)
        echo "Listing VPCs  in $aws_region."
        aws vpc describe-vpcs --region $aws_region
        ;;
    iam)
        echo "Listing IAM Users in $aws_region."
        aws iam list-users --region $aws_region
        ;;
    lambda)
        echo "Listing Lambda functions in $aws_region."
        aws lambda list-functions --region $aws_region
        ;;
    eks)
        echo "Listing EKS clusters in $aws_region."
        aws eks list-clusters --region $aws_region
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    *)
        echo "Service $aws_service is not supported."
        exit 1
        ;;
esac