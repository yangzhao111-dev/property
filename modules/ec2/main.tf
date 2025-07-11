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

 
  root_block_device = var.root_block_device
 
  user_data = <<-EOT
              <powershell>
              # 获取附加的磁盘
              $disk = Get-Disk | Where-Object { $_.OperationalStatus -eq 'Offline' }
              # 初始化磁盘并将其格式化为 NTFS
              $disk | Set-Disk -IsOffline $false -IsReadOnly $false
              $partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -AssignDriveLetter
              Format-Volume -DriveLetter $partition.DriveLetter -FileSystem NTFS -Confirm:$false
              </powershell>
              EOT

  # ebs_block_device = var.ebs_block_device
  ebs_volumes = var.ebs_volumes  // v6 new name

  tags = var.tags
}


resource "aws_eip" "public_ip" {
  count    = var.is_public ? 1 : 0
  instance = module.ec2.id
}

output "is_public" {
  description = "The list of extra disks to be attached."
  value       = var.is_public
}
