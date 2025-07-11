locals {
  public_subnet_names   = toset([for k, v in var.azs : "${var.name}-subnet-public${k + 1}-${v}"])
  private_subnet_names  = toset([for k, v in var.azs : "${var.name}-subnet-private${k + 1}-${v}"])
  public_subnet_suffix  = "rtb-public"
  private_subnet_suffix = "rtb-private"

  tags = {
    "deploy:by"        = "terraform"
    "terraform:module" = "vpc"
  }
}
