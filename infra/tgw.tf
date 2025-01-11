module "tgw" {
  source = "../modules/tgw"

  name                        = local.tgw_name
  amazon_side_asn             = var.tgw.amazon_side_asn
  transit_gateway_cidr_blocks = var.tgw.transit_gateway_cidr_blocks

  vpc_attachments = { for vpc_key, v in var.tgw_attached_vpcs : vpc_key => {
    vpc_id     = module.vpc[vpc_key].values.id
    subnet_ids = module.vpc[vpc_key].values.private_subnets

    dns_support  = true
    ipv6_support = false

    tgw_routes = v.tgw_routes
    tags = {
      Name = format(local.tgw_attachmemt_name_fmt, vpc_key)
    }
  } }

  route_tables_for_tgw = flatten([
    for vpc_key, v in var.extra_route_tables_for_tgw : [
      for rtb_id in concat(module.vpc[vpc_key].values.public_route_table_ids, module.vpc[vpc_key].values.private_route_table_ids) : [
        for cidr in v.cidrs : {
          route_table_id = rtb_id
          cidr           = cidr
        }
      ]
    ]
  ])

  tags = merge(local.tags, var.tags)

  tgw_route_table_tags = {
    Name = "${local.tgw_name}-vpc-"
  }
}
