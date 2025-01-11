module "s3_bucket" {
  source = "../modules/s3"

  for_each      = var.s3_buckets

  bucket_name   = each.value.bucket_name  
  acl           = each.value.acl   
  lifecycle_rules = each.value.lifecycle_rules

  tags = merge(local.tags, var.tags, {
    "s3_bucket:type" = "${each.key}"
  })
}

output "s3_bucket" {
  value = {
    for idx, s3_bucket in module.s3_bucket : idx => s3_bucket.values
  }
}
