output "bucket_name" {
  description = "bucket friendly name"
  value       = module.init.bucket_name
}

output "dynamodb_table_name" {
  description = "dynamodb friendly name"
  value       = module.init.dynamodb_table_name
}
