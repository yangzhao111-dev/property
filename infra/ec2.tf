module "ec2" {
  source   = "../modules/ec2"
  for_each = var.ec2s

  create        = each.value.create
  name          = "${local.ec2_name_prefix}-${each.key}"
  instance_name = "${local.ec2_name_prefix}-${each.key}"
  vpc_id        = module.vpc[each.value.vpc_key].values.id

  image_id            = each.value.image_id
  instance_type       = each.value.instance_type
  management_vpc_cidr = module.vpc.mgt.values.cidr
  is_public           = each.value.is_public
  subnet_id = (each.value.is_public
    ? module.vpc[each.value.vpc_key].values.public_subnets[0]
  : module.vpc[each.value.vpc_key].values.private_subnets[0])
  ssh_key_name = each.value.ssh_key_name
  root_block_device = each.value.root_block_device

  # ebs_block_device = each.value.ebs_block_device

  #aws provider 6 new name: ebs_block_device_mappings
  ebs_volumes = each.value.ebs_volumes

  security_group_ingress_cidr_rules = each.value.security_group_ingress_cidr_rules

  tags = merge(local.tags, var.tags, {
    "asg:type" = "${each.key}"
  })
}

