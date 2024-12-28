module "vpc_app" {
  source = "../modules/vpc"

  create      = var.create_vpc_app
  country     = var.country
  environment = var.environment

  azs  = var.vpc_app_azs
  cidr = var.vpc_app_cidr

  # Public - Create One Internet Gateway across 3 azs
  public_subnets = var.vpc_app_public_subnets

  # Private - No NAT Gateway & No Internet access
  private_subnets = var.vpc_app_private_subnets

  tags = merge(local.tags, {
    "vpc:type" = "app"
  })
}
