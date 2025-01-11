variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

# VPC

variable "create" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "create_endpoints" {
  description = "Controls if VPC endpoints should be created"
  type        = bool
  default     = true
}
