output "vpc_name" {
  value = module.vpc.name
}

output "vpc_cidr" {
  value = module.vpc.cidr
}

output "vpc_private_cubnets" {
  value = module.vpc.private_subnets
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}