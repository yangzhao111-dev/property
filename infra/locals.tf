locals {
  vpc_name_prefix = "${var.environment}-${var.country}"
  alb_name_prefix = "${var.environment}-${var.country}"
  tg_name_prefix  = "${var.environment}-${var.country}" // target group
  asg_name_prefix = "${var.environment}-${var.country}"
  ec2_name_prefix = "${var.environment}-${var.country}"
  sg_name_prefix  = "${var.environment}-${var.country}" // security group
  s3_name_prefix  = "${var.environment}-${var.country}"   // no "-ipx"

  tgw_name                = "${var.environment}-${var.country}-tgw"           // transit gateway
  tgw_attachmemt_name_fmt = "${var.environment}-${var.country}-%s-tgw-attach" // transit gateway

  tags = {
    "deploy:repository" = "ie-infra/ie-infra-aws-us"
  }
}
