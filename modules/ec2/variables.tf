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


variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
  default     = 10
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

