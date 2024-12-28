output "bucket_name" {
  description = "bucket friendly name"
  value       = aws_s3_bucket.this.bucket
}

output "dynamodb_table_name" {
  description = "dynamodb friendly name"
  value       = aws_dynamodb_table.this.id
}
