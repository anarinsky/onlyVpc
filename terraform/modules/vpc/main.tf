resource "aws_vpc" "vpc_vars" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = merge(var.tags, map("Name", format("%s", var.name)))
}

data "aws_vpc" "my-vpc" {
  id = aws_vpc.vpc_vars.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_vars.id
  tags   = merge(var.tags, map("Name", format("%s-igw", var.name)))
}

resource "aws_route_table" "public" {
  vpc_id           = aws_vpc.vpc_vars.id
  tags             = merge(var.tags, map("Name", format("%s-rt-public", var.name)))
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.natgw.*.id, count.index)
  count                  = length(var.private_subnets) * lookup(map(var.enable_nat_gateway, 1), "true", 0)
}

resource "aws_route_table" "private" {
  vpc_id           = aws_vpc.vpc_vars.id
  count            = length(var.private_subnets)
  tags             = merge(var.tags, map("Name", format("%s-rt-private-%s", var.name, element(var.azs, count.index))))
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc_vars.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.azs, count.index)
  count             = length(var.private_subnets)
  tags              = merge(var.tags, map("Name", format("%s-subnet-private-%s", var.name, element(var.azs, count.index))))
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc_vars.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(var.azs, count.index)
  count             = length(var.public_subnets)
  tags              = merge(var.tags, map("Name", format("%s-subnet-public-%s", var.name, element(var.azs, count.index))))

  map_public_ip_on_launch = var.map_public_ip_on_launch
}

resource "aws_eip" "nateip" {
  vpc   = true
  count = length(var.private_subnets) * lookup(map(var.enable_nat_gateway, 1), "true", 0)
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = element(aws_eip.nateip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  count         = length(var.private_subnets) * lookup(map(var.enable_nat_gateway, 1), "true", 0)

  depends_on = [
    aws_internet_gateway.internet_gateway
  ]
  tags = merge(var.tags, map("Name", format("%s", var.name)))
}


