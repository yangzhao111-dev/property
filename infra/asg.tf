module "asg" {
  source = "../modules/asg"

  for_each = var.asgs

  create        = each.value.create
  name          = "${local.asg_name_prefix}-${each.key}"
  instance_name = "${local.ec2_name_prefix}-${each.key}"

  image_id      = each.value.image_id
  instance_type = each.value.instance_type
  min_size      = each.value.min_size
  max_size      = each.value.max_size
  disk_size_gb  = each.value.disk_size_gb

  private_subnets = module.vpc[each.key].values.private_subnets

  target_group_arn = module.alb[each.key].values.target_groups.ex_asg.arn

  management_vpc_cidr   = module.vpc.mgt.values.cidr
  vpc_id                = module.vpc[each.key].values.id
  alb_security_group_id = module.alb[each.key].values.security_group_id

  tags = merge(local.tags, var.tags, {
    "asg:type" = "${each.key}"
  })
}

output "asg" {
  value = {
    for idx, vpc in module.asg : idx => asg.values
  }
}
