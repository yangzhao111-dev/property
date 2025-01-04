
resource "tls_private_key" "ssh" {
  count = var.create_ssh_key ? 1 : 0

  algorithm = "ED25519"
}

resource "aws_key_pair" "ssh" {
  count = var.create_ssh_key ? 1 : 0

  key_name   = "${var.name}-asg-node"
  public_key = tls_private_key.ssh[0].public_key_openssh
}
