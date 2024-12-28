variable "country" {
  type        = string
  description = "Country name: [us]"
}

variable "environment" {
  type        = string
  description = "Environment name: [dev, stage, prod]"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

# VPC

variable "create" {
  type        = bool
  description = "Controls if VPC should be created (it affects almost all resources)"
  default     = true
}

variable "azs" {
  type        = list(string)
  description = "A list of availability zones names or ids in the region"
}

variable "cidr" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets inside the VPC"
  default     = []
}
