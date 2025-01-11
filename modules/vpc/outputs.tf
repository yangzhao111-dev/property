output "values" {
  value = {
    id                      = module.vpc.vpc_id
    name                    = "${module.vpc.name}-vpc"
    arn                     = module.vpc.vpc_arn
    azs                     = module.vpc.azs
    cidr                    = module.vpc.vpc_cidr_block
    igw_id                  = module.vpc.igw_id
    igw_arn                 = module.vpc.igw_arn
    public_subnets          = module.vpc.public_subnets
    private_subnets         = module.vpc.private_subnets
    private_route_table_ids = module.vpc.private_route_table_ids
    public_route_table_ids  = module.vpc.public_route_table_ids
    natgw_ids               = module.vpc.natgw_ids
  }
}
