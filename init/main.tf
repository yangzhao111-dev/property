module "init" {
  source = "../modules/init"

  deployer_user       = "RootDeployer"
  bucket_name         = "ipropertyexpress-tfsates"
  dynamodb_table_name = "ipropertyexpress-tfsates-locktable"

  tags = {
    "deploy:repository" = "ie-infra/ie-infra-aws-us"
  }
}
