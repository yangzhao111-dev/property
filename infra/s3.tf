module "s3_bucket" {
  source = "../modules/s3"

  for_each = var.s3_buckets

  bucket_name              = "${local.s3_name_prefix}-${each.value.bucket_name}"
  control_object_ownership = each.value.control_object_ownership
  object_ownership         = each.value.object_ownership
  acl                      = each.value.acl
  lifecycle_rules          = each.value.lifecycle_rules

  tags = merge(local.tags, var.tags, {
    "s3_bucket:type" = "${each.key}"
  })
}

output "s3_bucket" {
  value = {
    for idx, s3_bucket in module.s3_bucket : idx => s3_bucket.values
  }
}
