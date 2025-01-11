variable "country" {
  description = "Country name: [us]"
  type        = string
}

variable "environment" {
  description = "Environment name: [dev, stage, prod]"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

# VPC

variable "vpcs" {
  description = "VPC variables"
  type = map(object({
    # Controls if VPC should be created (it affects almost all resources)
    create = optional(bool, true)
    # Controls if VPC endpoints should be created
    create_endpoints = optional(bool, true)
    # A list of availability zones names or ids in the region
    azs = list(string)
    # The CIDR block for the VPC. Default value is a valid CIDR,
    # but not acceptable by AWS and should be overridden
    cidr = string
    # A list of public subnets inside the VPC
    public_subnets = list(string)
    # A list of private subnets inside the VPC
    private_subnets = list(string)
  }))
  default = {}
}

# ALB

variable "albs" {
  description = "ALB variables"
  type = map(object({
    # Controls if ALB should be created (it affects almost all resources)
    create = optional(bool, true)
    # Controls deletion protection of the load balancer
    enable_deletion_protection = optional(bool, false)
    # TCP port of backend service
    backend_port = optional(number, 80)
    vpc_key      = optional(string, "")
  }))
  default = {}
}

# ACM

variable "acms" {
  description = "ACM certificate variables"
  type = map(object({
    create       = optional(bool, true)
    domain_names = optional(list(string), [])
  }))
  default = {}
}

# ASG

variable "asgs" {
  description = "ASG variables"
  type = map(object({
    create         = optional(bool, true)
    image_id       = optional(string, "")
    instance_type  = optional(string, "")
    min_size       = optional(number, 1)
    max_size       = optional(number, 1)
    disk_size_gb   = optional(number, 10)
    create_ssh_key = optional(bool, false)
    ssh_key_name   = optional(string, "")
    vpc_key        = optional(string, "")
    alb_key        = optional(string, "")
  }))
  default = {}
}


variable "ec2s" {
  description = "ASG variables"
  type = map(object({
    create        = optional(bool, true)
    image_id      = optional(string, "") // Windows 2025
    instance_type = optional(string, "")
    disk_size_gb  = optional(number, 60)
    ssh_key_name  = optional(string, "") // manuall add key pair
    vpc_key       = optional(string, "")
    alb_key       = optional(string, "")
    is_public     = optional(bool, false)
  }))
  default = {}
}

# S3 bucket
variable "s3_buckets" {
  description = "A map of S3 bucket configurations"
  type = map(object({
    bucket_name     = string
    acl             = string
    lifecycle_rules = list(object({
      id         = string
      enabled    = bool
      expiration = object({
        days = optional(number) # 可选字段，允许为 null
      })
      transition = list(object({
        days          = number
        storage_class = string
      }))
      filter = object({
        prefix = optional(string) # 可选字段，允许为空
      })
    }))
  }))
}



