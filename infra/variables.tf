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
    vpc_tags        = optional(map(string), {})
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

    name             = optional(string,"")
    desired_capacity = optional(number, 1)
    
    scaling_policies = optional(list(object({
      policy_name         = string
      policy_type         = optional(string, "StepScaling")
      enabled             = optional(bool, true)
      alarm_name          = optional(string)  
      metric_name         = optional(string, "CPUUtilization")
      threshold           = optional(number, 20)
      adjustment_type     = optional(string, "ChangeInCapacity")
      scaling_adjustment  = optional(number, -1)
      cooldown            = optional(number, null)
      evaluation_periods  = optional(number, 2)
      period              = optional(number, 60)
      comparison_operator = optional(string, "LessThanOrEqualToThreshold")
    })),[])
  }))
  default = {}
}


variable "ec2s" {
  description = "ASG variables"
  type = map(object({
    create        = optional(bool, true)
    image_id      = optional(string, "") // Windows 2025
    instance_type = optional(string, "")
    ssh_key_name   = optional(string, "")
    root_block_device   = optional(list(object({
      encrypted = optional(bool, true)
      volume_type = optional(string, "gp3")
      volume_size = optional(number, 60)
      throughput  = optional(number, 125)
      iops = optional(number, 3000)
    })), [])
    ebs_volumes   = optional(list(object({  //new name
      encrypted = optional(bool, true)
      device_name = optional(string, "xvdb")
      volume_type = optional(string, "gp3")
      volume_size = optional(number, 600)
      throughput  = optional(number, 125)
      iops = optional(number, 3000)
    })), [])
    
    vpc_key       = optional(string, "")
    alb_key       = optional(string, "")
    is_public     = optional(bool, false)
    security_group_ingress_cidr_rules = optional(list(object({
      description = string
      cidr_block  = string
      port        = number
      ip_protocol = optional(string, "tcp")
    })), [])
  }))
  default = {}
}

# S3 bucket
variable "s3_buckets" {
  description = "A map of S3 bucket configurations"
  type = map(object({
    bucket_name              = string
    control_object_ownership = optional(bool, false)
    object_ownership         = optional(string, "BucketOwnerEnforced")
    acl                      = string
    lifecycle_rules = list(object({
      id      = string
      enabled = bool
      expiration = object({
        days = optional(number, null) # 可选字段，允许为 null
      })
      transition = list(object({
        days          = number
        storage_class = string
      }))
      filter = object({
        prefix = optional(string, "") # 可选字段，允许为空
      })
    }))
  }))
}

# tgw

variable "tgw" {
  description = "Transit gateway variables"
  type = object({
    amazon_side_asn             = number
    transit_gateway_cidr_blocks = list(string)
  })
}

variable "tgw_attached_vpcs" {
  description = "Transit gateway vpc attachments variables"
  type = map(object({
    tgw_routes = list(object({
      destination_cidr_block = string
      is_public              = optional(bool, false)
    }))
  }))
  default = {}
}

variable "extra_route_tables_for_tgw" {
  description = "Extra route tables for transit gateway"
  type = map(object({
    cidrs     = list(string)
    is_public = optional(bool, false)
  }))
  default = {}
}
