# Service provider configuration
provider "aws" {
  region = "us-east-1"  # AWS region where the resources will be created
}

# EC2 instance resource
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c94855ba95c71c99"  # Amazon Machine Image ID
  instance_type = "t2.micro"  # Instance type

  tags = {
    Name = "main-instance"  # Name of the instance
  }
}

# ECR repository resource
resource "aws_ecr_repository" "my_ecr_repo" {
  name = "ecr-repo"  # Name of the repository
}

# IAM role for EKS
resource "aws_iam_role" "eks_iam_role" {
  name = "my-eks-role"  # Name of the role

  # Assume role policy for EKS service
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach EKS cluster policy to the IAM role
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"  # Policy ARN
  role       = aws_iam_role.eks_iam_role.name  # IAM role name
}

# Attach ECR read-only policy to the IAM role
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"  # Policy ARN
  role       = aws_iam_role.eks_iam_role.name  # IAM role name
}

# EKS cluster resource
resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-eks-cluster"  # Name of the EKS cluster
  role_arn = aws_iam_role.eks_iam_role.arn  # IAM role ARN

  # VPC configuration
  vpc_config {
    subnet_ids = [var.subnet_id_1, var.subnet_id_2]  # Subnet IDs
  }

  # Dependencies
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-EKS,
  ]
}

# S3 bucket for storing Terraform state files
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "terraform-state-files"  # Bucket name
  acl    = "private"  # ACL configuration

  # Enable versioning
  versioning {
    enabled = true
  }

  tags = {
    Name = "my-terraform-state-files-bucket"  # Name of the bucket
  }
}
