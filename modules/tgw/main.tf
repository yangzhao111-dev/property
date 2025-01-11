# https://registry.terraform.io/modules/terraform-aws-modules/transit-gateway/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-transit-gateway/tree/master/examples
module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.0"

  create_tgw = var.create

  name            = var.name
  description     = "TGW ${var.name}"
  amazon_side_asn = var.amazon_side_asn

  enable_default_route_table_association = true
  enable_default_route_table_propagation = true
  # When "true" there is no need for RAM resources if using multiple AWS accounts
  enable_auto_accept_shared_attachments = true
  # TODO: https://github.com/terraform-aws-modules/terraform-aws-transit-gateway/pull/133
  # security_group_referencing_support = true

  share_tgw = false

  transit_gateway_cidr_blocks = var.transit_gateway_cidr_blocks

  vpc_attachments = var.vpc_attachments

  tags = merge(var.tags, local.tags)
}
