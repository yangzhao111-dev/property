
resource "aws_security_group" "this" {
  name        = "${var.name}-ec2-sg"
  description = "Ec2 instance security rules"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.name}-ec2-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "internal-access" {
  count = var.is_public ? 0 : 1

  security_group_id = aws_security_group.this.id

  description = "Remote Access from Management VPC"
  from_port   = 3389
  to_port     = 3389
  ip_protocol = "tcp"
  cidr_ipv4   = var.management_vpc_cidr
}

resource "aws_vpc_security_group_ingress_rule" "cidrs" {
  for_each = {
    for k, v in var.security_group_ingress_cidr_rules : "${v.ip_protocol}-${v.cidr_block}-${v.port}" => {
      description = v.description
      port        = v.port
      ip_protocol = v.ip_protocol
      cidr_block  = v.cidr_block
    }
  }

  security_group_id = aws_security_group.this.id

  description = each.value.description
  from_port   = each.value.port
  to_port     = each.value.port
  ip_protocol = each.value.ip_protocol
  cidr_ipv4   = each.value.cidr_block
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id

  from_port   = -1
  to_port     = -1
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
