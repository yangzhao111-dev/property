variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

# ACM

variable "create" {
  description = "Whether to create ACM certificate"
  type        = bool
  default     = true
}

variable "domain_names" {
  description = "Domain names for certificate"
  type        = list(string)
}
