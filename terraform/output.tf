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

<<<<<<< HEAD
output "azs" {
  value = data.aws_availability_zones.available.names[1]
=======
output "vpc_state" {
  value = data.aws_vpc.my-vpc.state
>>>>>>> 7cf0067435b59ad3efdb54f04e5860f01bd17849
}