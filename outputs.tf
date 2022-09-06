output "private_subnet_cidrs" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
