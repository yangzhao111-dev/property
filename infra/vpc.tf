module "vpc" {
  source = "../modules/vpc"

  for_each = var.vpcs

  create = each.value.create
  name   = "${local.vpc_name_prefix}-${each.key}"

  azs  = each.value.azs
  cidr = each.value.cidr

  public_subnets  = each.value.public_subnets
  private_subnets = each.value.private_subnets

  tags = merge(local.tags, {
    "vpc:type" = "${each.key}"
  })
}

output "vpc" {
  value = {
    for idx, vpc in module.vpc : idx => vpc.values
  }
}
