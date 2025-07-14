variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

# ASG

variable "create" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name used across the resources created"
  type        = string
}

variable "instance_name" {
  description = "Instance name"
  type        = string
}

variable "public_subnets" {
  description = "A list of private subnets"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets"
  type        = list(string)
  default     = []
}

variable "image_id" {
  description = "EC2 image ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}


# SG

variable "management_vpc_cidr" {
  description = "The CIDR block for the management VPC."
  type        = string
}

variable "app_vpc_cidr" {
  description = "The CIDR block for the APP VPC."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The ID for the VPC."
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "ID for the Subnet."
  type        = string
  default     = ""
}

variable "ec2_security_group_id" {
  description = "The ID of the EC2 security group."
  type        = string
  default     = ""
}

# SSH

variable "create_ssh_key" {
  description = "Create SSH key or not"
  type        = bool
  default     = false
}

variable "ssh_key_name" {
  description = "SSH key name"
  type        = string
  default     = ""
}

variable "is_public" {
  description = "is public"
  type        = bool
  default     = false
}

variable "security_group_ingress_cidr_rules" {
  description = "Public cidrs for remote access"
  type = list(object({
    description = string
    cidr_block  = string
    port        = number
    ip_protocol = optional(string, "tcp")
  }))
  default = []
}

# v6+ map
variable "root_block_device" {
  description = "The sizes of the extra disks to attach to the instance (in GB). Leave empty for no extra disks."
  type = object({
    encrypted = optional(bool, true)
    volume_type = optional(string, "gp3")
    volume_size = optional(number, 600)
    throughput  = optional(number, 125)
    iops  = optional(number, 3000)
  })
  default = null # 默认没有传递额外磁盘
}

variable "ebs_block_device" {
  description = "The sizes of the extra disks to attach to the instance (in GB). Leave empty for no extra disks."
  type = list(object({
    encrypted = optional(bool, true)
    device_name = optional(string, "xvdb")
    volume_type = optional(string, "gp3")
    volume_size = optional(number, 600)
    throughput  = optional(number, 125)
    iops  = optional(number, 3000)
  }))
  default = [] # 默认没有传递额外磁盘
}

# tf aws 6.0 upgrade
variable "ebs_volumes" {
  description = "Map of additional EBS volumes to attach"
  type = map(object({
    device_name           = optional(string)
    type                  = optional(string)
    size                  = optional(number)
    delete_on_termination = optional(bool)
    encrypted             = optional(bool)
    iops                  = optional(number)
    throughput            = optional(number)
    tags                  = optional(map(string))
  }))
  default = {}
}