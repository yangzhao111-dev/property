module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"

  create_bucket = var.create

  bucket         = var.bucket_name
  lifecycle_rule = var.lifecycle_rules

  acl                      = var.acl
  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership

  tags = merge(var.tags, local.tags)
}
