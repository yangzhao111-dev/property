variable "country" {
  type        = string
  description = "Country name: [us]"
}

variable "environment" {
  type        = string
  description = "Environment name: [dev, stage, prod]"
}

variable "aws_account_id" {
  type        = string
  description = "AWS account ID"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

# VPC

## app

variable "create_vpc_app" {
  type        = bool
  description = "Controls if VPC should be created (it affects almost all resources)"
  default     = true
}

variable "vpc_app_azs" {
  type        = list(string)
  description = "A list of availability zones names or ids in the region"
  default     = []
}

variable "vpc_app_cidr" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = ""
}

variable "vpc_app_public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "vpc_app_private_subnets" {
  type        = list(string)
  description = "A list of private subnets inside the VPC"
  default     = []
}

## mgt

variable "create_vpc_mgt" {
  type        = bool
  description = "Controls if VPC should be created (it affects almost all resources)"
  default     = true
}

variable "vpc_mgt_azs" {
  type        = list(string)
  description = "A list of availability zones names or ids in the region"
  default     = []
}

variable "vpc_mgt_cidr" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = ""
}

variable "vpc_mgt_public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "vpc_mgt_private_subnets" {
  type        = list(string)
  description = "A list of private subnets inside the VPC"
  default     = []
}
