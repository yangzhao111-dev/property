# https://registry.terraform.io/modules/terraform-aws-modules/acm/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-acm
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 5.0"

  create_certificate        = true
  domain_name               = var.cert_domain_names[0]
  subject_alternative_names = slice(var.cert_domain_names, 1, length(var.cert_domain_names))
  validate_certificate      = false
  validation_method         = "DNS"
}

output "acm" {
  value = module.acm
}
