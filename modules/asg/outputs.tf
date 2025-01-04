output "values" {
  value = module.asg
}

output "ssh_private_key" {
  value     = tls_private_key.ssh.*.private_key_pem
  sensitive = true
}
