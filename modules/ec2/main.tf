# https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-autoscaling
module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name            = "${var.name}-ec2"
  
  instance_type          = var.instance_type
  # monitoring             = true
  vpc_security_group_ids = [aws_security_group.this_ec2.id]
  subnet_id              = var.subnet_id
  key_name        = local.ssh_key_name

  tags = merge(var.tags, local.tags)
}
