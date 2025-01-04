# https://registry.terraform.io/modules/terraform-aws-modules/acm/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-acm
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 5.0"

  create_certificate        = var.create
  domain_name               = var.domain_names[0]
  subject_alternative_names = length(var.domain_names) > 1 ? slice(var.domain_names, 1, length(var.domain_names)) : []
  validate_certificate      = false
  validation_method         = "DNS"

  tags = merge(var.tags, local.tags)
}
