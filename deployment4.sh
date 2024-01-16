#!/bin/bash

# Check if the image name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <image_name>"
    exit 1
fi

# Set image name from command-line argument
image_name="$1"

# Rest of your script...

# Get AWS account ID
account_id() {
    echo "Fetching AWS Account ID..."
    aws_account_id=$(aws sts get-caller-identity --query "Account" --output text)
}

# Docker login
docker_login() {
    echo "Logging into Docker..."
    login_command=$(aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "${aws_account_id}".dkr.ecr.us-east-1.amazonaws.com)
    echo "${login_command}"
}

# Build Docker image
build_image() {
    echo "Building Docker image..."
    build_output=$(docker build -t "${image_name}" .)
    echo "${build_output}"
}

# Tag Docker image
tag_image() {
    echo "Tagging Docker image..."
    tag_output=$(docker tag "${image_name}":latest "${aws_account_id}".dkr.ecr.us-east-1.amazonaws.com/"${image_name}":latest)
    echo "${tag_output}"
}

# Push Docker image
push_image() {
    echo "Pushing Docker image to ECR..."
    docker push "${aws_account_id}".dkr.ecr.us-east-1.amazonaws.com/"${image_name}":latest
    push_result=$?
    return "${push_result}"
}

# Main execution

# Get AWS account ID
account_id

# Docker login
docker_login

# Build Docker image
build_image

# Tag Docker image
tag_image

# Push Docker image 
push_image
push_result=$?
