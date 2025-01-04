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
  }))
  default = {}
}

# ACM

variable "cert_domain_names" {
  description = "Domain names for certificate"
  type        = list(string)
}
