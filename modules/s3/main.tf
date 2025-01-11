module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"
  
  bucket          = var.bucket_name
  lifecycle_rule  = var.lifecycle_rules
  acl             = var.acl
  
  tags = merge(var.tags, local.tags)
}
