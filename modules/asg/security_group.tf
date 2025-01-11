
resource "aws_security_group" "this" {
  name        = "${var.name}-asg-node-sg"
  description = "ASG node security rules"
  vpc_id      = var.vpc_id

  ingress {
    description = "Remote access from Management VPC"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.management_vpc_cidr]
  }

  ingress {
    description     = "Traffic from ALB ${var.name}"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [var.alb_security_group_id]
  }

  ingress {
    description = "Traffic from self VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "Traffic from self ${var.name}"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "${var.name}-asg-node-sg"
  })
}
