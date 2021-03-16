provider "aws" {
  region  = var.region
}

locals {
  current_env = var.env_name

  default_tags = {
    Terraform   = "true"
    ProjectName = var.project_name
    Environment = var.env_name
    CreationDate = var.creation_date
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
      env = "Development"
      date = "02-14-2021"
    }
  )
}
