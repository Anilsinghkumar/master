module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = var.name

  cidr                  = var.private_cidr
  secondary_cidr_blocks = [var.public_cidr]
  azs                   = var.azs

  private_subnets = cidrsubnets(var.private_cidr, 4, 4, 4, 4)
  public_subnets  = cidrsubnets(var.public_cidr, 2, 2, 2, 2)

  enable_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/alb-ingress"    = ""
    "kubernetes.io/role/elb"            = ""
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/internal-elb"   = "1"
  }

  tags = merge(var.default_tags, {})
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment" {
  subnet_ids         = module.vpc.private_subnets
  transit_gateway_id = var.tgw_id
  vpc_id             = module.vpc.vpc_id

  dns_support = "enable"

  tags = merge(var.default_tags, {
    Name = var.name
  })
}

resource "aws_route" "tgw_rfc_1918_1" {
  count = length(module.vpc.private_route_table_ids)

  route_table_id         = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = var.tgw_id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.tgw_attachment
  ]
}

resource "aws_route" "tgw_rfc_1918_2" {
  count = length(module.vpc.private_route_table_ids)

  route_table_id         = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block = "172.16.0.0/12"
  transit_gateway_id     = var.tgw_id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.tgw_attachment
  ]
}

resource "aws_route" "tgw_rfc_1918_3" {
  count = length(module.vpc.private_route_table_ids)

  route_table_id         = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block = "192.168.0.0/16"
  transit_gateway_id     = var.tgw_id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.tgw_attachment
  ]
}
