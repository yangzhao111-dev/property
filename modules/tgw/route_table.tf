resource "aws_route" "this" {
  for_each = {
    for k, v in var.route_tables_for_tgw : "${v.route_table_id}-${v.cidr}" => {
      route_table_id = v.route_table_id
      cidr           = v.cidr
    }
  }

  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = module.tgw.ec2_transit_gateway_id
}
