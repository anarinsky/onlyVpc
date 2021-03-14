provider "aws" {
  region  = var.region
  version = "~> 2.66.0"
}
resource "aws_s3_bucket" "s3" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

<<<<<<< HEAD
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
=======
terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "rental-app-tf-state-123"
    key            = "terraform/us-east-1/develop/db_monitoring_prototype.tfstate"
>>>>>>> 88de8ff9b67906df1fb42b6b972e1583ca7281b7
  }
}

locals {
  current_env = var.env_name

  default_tags = {
    Terraform   = "true"
    ProjectName = var.project_name
    Environment = var.env_name
  }
}

data "aws_availability_zones" "available" {
}

data "aws_caller_identity" "aws-identity" {
}


module "vpc" {
  source               = "./modules/vpc"
  name                 = "${var.env_name}-${lower(var.project_name)}-vpc"
  cidr                 = var.cidr
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = "false"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  azs                  = slice(data.aws_availability_zones.available.names, 0, length(var.private_subnets))

  tags = merge(
    local.default_tags,
    {
      SomeTag = "SomeValue"
    }
  )
}
