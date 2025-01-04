output "values" {
  value = {
    id                 = module.alb.id
    arn                = module.alb.arn
    dns_name           = module.alb.dns_name
    zone_id            = module.alb.zone_id
    listeners          = module.alb.listeners
    target_groups      = module.alb.target_groups
    security_group_arn = module.alb.security_group_arn
    route53_records    = module.alb.route53_records
  }
}
