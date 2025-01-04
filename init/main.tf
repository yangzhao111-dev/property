module "init" {
  source = "../modules/init"

  deployer_user       = "RootDeployer"
  bucket_name         = "ipropertyexpress-tfstates"
  dynamodb_table_name = "ipropertyexpress-tfstates-locktable"

  tags = {
    "deploy:repository" = "ie-infra/ie-infra-aws-us"
  }
}
