terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "tpe-lab-tf-tofu-backend"
    key    = "lab/terraform/terraform.tfstate"
    region = "eu-north-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tf-vpc"
    IaC  = "terraform"
    # Iac = "opentofu"
  }
}