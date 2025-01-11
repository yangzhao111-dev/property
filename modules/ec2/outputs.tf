output "instance_id" {
  value = module.ec2.id
}

output "private_ip" {
  value = module.ec2.private_ip
}

output "public_ip" {
  value = var.is_public ? aws_eip.public_ip[0].public_ip : "No Public IP"
}
