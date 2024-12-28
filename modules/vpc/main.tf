# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-vpc
module "vpc" {
  count = var.create ? 1 : 0

  source = "terraform-aws-modules/vpc/aws"

  manage_default_vpc            = false
  create_database_subnet_group  = false
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  name = local.name
  azs  = var.azs
  cidr = var.cidr

  single_nat_gateway   = true
  enable_nat_gateway   = true
  enable_dns_hostnames = true

  # Public - Create One Internet Gateway across 3 azs
  public_subnets = var.public_subnets

  # Private - No NAT Gateway & No Internet access
  private_subnets = var.private_subnets

  tags = merge(var.tags, local.tags)

  vpc_tags = {
    Name = "${local.name}-vpc"
  }

  public_subnet_names   = local.public_subnet_names
  private_subnet_names  = local.private_subnet_names
  public_subnet_suffix  = local.public_subnet_suffix
  private_subnet_suffix = local.private_subnet_suffix

  nat_gateway_tags = {
    Name = "${local.name}-natgw"
  }

  igw_tags = {
    Name = "${local.name}-igw"
  }
}

module "endpoints" {
  count = var.create ? 1 : 0

  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id = module.vpc[0].vpc_id

  create_security_group = false

  endpoints = {
    s3 = {
      service      = "s3"
      service_type = "Gateway"
      route_table_ids = flatten([
        module.vpc[0].private_route_table_ids,
      ])
      tags = { Name = "${local.name}-vpce-s3" }
    },
    dynamodb = {
      service      = "dynamodb"
      service_type = "Gateway"
      route_table_ids = flatten([
        module.vpc[0].private_route_table_ids,
      ])
      tags   = { Name = "${local.name}-vpce-dynamodb" }
    },
  }

  tags = merge(var.tags, local.tags)
}
