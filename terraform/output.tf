output "vpc_private_cubnets" {
  value = module.vpc.private_subnets
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}

output "cidr_block" {
  value = module.vpc.cidr_block
  }

output "azs" {
  value = slice(data.aws_availability_zones.available.names, 0, 2)
}

output "env" {
  value = module.vpc.vpc_tag_env
}
