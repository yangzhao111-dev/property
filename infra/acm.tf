# https://registry.terraform.io/modules/terraform-aws-modules/acm/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-acm
module "acm" {
  source = "../modules/acm"

  for_each = var.acms

  create       = each.value.create
  domain_names = each.value.domain_names

  tags = merge(local.tags, var.tags)
}

output "acm" {
  value = {
    for idx, acm in module.acm : idx => acm.values
  }
}
