module "alb" {
  source = "../modules/alb"

  for_each = var.albs

  create = each.value.create
  name   = "${local.alb_name_prefix}-${each.key}"

  vpc_id         = module.vpc[each.key].values.id
  vpc_cidr       = module.vpc[each.key].values.cidr
  public_subnets = module.vpc[each.key].values.public_subnets

  enable_deletion_protection = each.value.enable_deletion_protection

  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  listeners = {
    ex_http = {
      port            = 80
      protocol        = "HTTP"

      forward = {
        target_group_key = "ex_asg"
      }
    }
    /**
    // TODO: validate certificate creation
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    ex_https = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
      certificate_arn = module.acm.acm_certificate_arn

      forward = {
        target_group_key = "ex_asg"
      }
    }
    //*/
  }
  target_groups = {
    ex_asg = {
      name                              = "${local.tg_name_prefix}-${each.key}"
      protocol                          = "HTTP"
      port                              = each.value.backend_port
      target_type                       = "instance"
      deregistration_delay              = 15
      load_balancing_cross_zone_enabled = true

      # There's nothing to attach here in this definition.
      # The attachment happens in the ASG module above
      create_attachment = false
    }
  }

  tags = merge(local.tags, {
    "alb:type" = "${each.key}"
  })
}

output "alb" {
  value = {
    for idx, alb in module.alb : idx => alb.values
  }
}
