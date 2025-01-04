module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  create = var.create

  name    = var.name
  vpc_id  = var.vpc_id
  subnets = var.public_subnets

  load_balancer_type = "application"

  enable_deletion_protection = var.enable_deletion_protection

  # Security Group
  create_security_group          = true
  security_group_name            = "${var.name}-alb-sg"
  security_group_use_name_prefix = false
  security_group_ingress_rules   = var.security_group_ingress_rules
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = var.vpc_cidr
    }
  }

  listeners = var.listeners

  target_groups = var.target_groups

  tags = merge(var.tags, local.tags)

  security_group_tags = {
    Name = "${var.name}-alb-sg"
  }
}
