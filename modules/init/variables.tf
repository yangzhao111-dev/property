variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

# IAM

variable "deployer_user" {
  type        = string
  description = "Name of depolyer user"
}

# s3

variable "bucket_name" {
  type        = string
  description = "Name of bucket to hold tf state"
}

# dynamodb

variable "dynamodb_table_name" {
  type        = string
  description = "Name of lock table for terraform"
}
