output "values" {
  value = {
    id              = module.vpc.vpc_id
    name            = "${module.vpc.name}-vpc"
    arn             = module.vpc.vpc_arn
    azs             = module.vpc.azs
    cidr            = module.vpc.vpc_cidr_block
    igw_id          = module.vpc.igw_id
    igw_arn         = module.vpc.igw_arn
    public_subnets  = module.vpc.public_subnets
    private_subnets = module.vpc.private_subnets
    natgw_ids       = module.vpc.natgw_ids
  }
}
