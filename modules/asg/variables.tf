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

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
  default     = null
}

variable "max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
  default     = null
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

variable "target_group_arn" {
  description = "Target group ARN for attchment"
  type        = string
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
  default     = 10
}

variable "scaling_policies" {
  description = "Scale-up,scale-down policy configuration."
  type        = any
  default     = []
}

# SG

variable "management_vpc_cidr" {
  description = "The CIDR block for the management VPC."
  type        = string
}

variable "vpc_id" {
  description = "The ID for the VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "The cidr for the VPC."
  type        = string
}

variable "alb_security_group_id" {
  description = "The ID of the ALB security group."
  type        = string
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
