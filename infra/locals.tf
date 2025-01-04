locals {
  vpc_name_prefix = "${var.environment}-${var.country}"
  alb_name_prefix = "${var.environment}-${var.country}"
  tg_name_prefix  = "${var.environment}-${var.country}"

  tags = {
    "deploy:repository" = "ie-infra/ie-infra-aws-us"
  }
}
