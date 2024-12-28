# ------------------------------------------------------------------------------
# Create the dynamodb table
# ------------------------------------------------------------------------------

resource "aws_dynamodb_table" "this" {
  name           = var.dynamodb_table_name
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(var.tags, local.tags, {
    "Name" = var.bucket_name
  })
}
