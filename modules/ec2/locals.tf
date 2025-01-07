locals {
  ssh_key_name = var.create_ssh_key ? aws_key_pair.ssh[0].key_name : var.ssh_key_name

  tags = {
    "deploy:by"        = "terraform"
    "terraform:module" = "ec2"
  }
}
