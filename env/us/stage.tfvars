# Base

country        = "us"
environment    = "stage"
aws_account_id = "539247459406"
aws_region     = "us-west-2"

# VPC

vpc_app_azs = [
  "us-west-2a",
  "us-west-2b",
  "us-west-2c",
]
vpc_app_cidr = "10.91.0.0/16"
vpc_app_public_subnets = [
  "10.91.0.0/24",
  "10.91.1.0/24",
  "10.91.2.0/24",
]
vpc_app_private_subnets = [
  "10.91.96.0/21",
  "10.91.104.0/21",
  "10.91.112.0/21",
]
