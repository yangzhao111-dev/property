terraform {
  backend "s3" {
    region         = ""
    bucket         = ""
    key            = ""
    dynamodb_table = ""
    encrypt        = true
  }
}
