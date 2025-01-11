# https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-autoscaling
module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  create                 = var.create
  name                   = "${var.name}-ec2"

  instance_type          = var.instance_type
  ami                    = var.image_id
  # monitoring             = true
  vpc_security_group_ids = [aws_security_group.this.id]
  subnet_id              = var.subnet_id
  key_name               = var.ssh_key_name

  associate_public_ip_address = var.is_public

  tags = var.tags
}


resource "aws_eip" "public_ip" {
  count    = var.is_public ? 1 : 0
  instance = module.ec2.id
}

