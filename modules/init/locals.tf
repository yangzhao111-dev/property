data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

locals {
  tags = {
    "deploy:by"       = "terraform"
    "terraform:module" = "init"
  }

  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  region     = data.aws_region.current.name

  deployer_user       = try(var.deployer_user, "RootDeployer")
  bucket_name         = try(var.bucket_name, "${local.account_id}-${local.region}-tfstates")
  dynamodb_table_name = try(var.dynamodb_table_name, "tfstates-locktable")
}
