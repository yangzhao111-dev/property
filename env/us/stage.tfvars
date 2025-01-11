# Base

country        = "us"
environment    = "stage"
aws_account_id = "539247459406"
aws_region     = "us-west-2"


# ASG

asgs = {
  app-nodejs = {
    image_id      = "ami-0e32864a4910bd3a9" // Windows 2025
    instance_type = "t3.medium"
    disk_size_gb  = 30
    ssh_key_name  = "instance-access-key" // manuall add key pair
    vpc_key       = "app"
    alb_key       = "app-nodejs"
  }
  app-web = {
    image_id      = "ami-0e32864a4910bd3a9" // Windows 2025
    instance_type = "t3.medium"
    disk_size_gb  = 30
    ssh_key_name  = "instance-access-key" // manuall add key pair
    vpc_key       = "app"
    alb_key       = "app-web"
  }
}

#EC2


ec2s = {
  app-bastion = {
    image_id      = "ami-0e32864a4910bd3a9" // Windows 2025
    instance_type = "t3.medium"
    disk_size_gb  = 70
    ssh_key_name  = "instance-access-key" // manuall add key pair
    vpc_key       = "mgt"
    is_public     = true
  }
  app-web = {
    image_id      = "ami-0e32864a4910bd3a9" // Windows 2025
    instance_type = "t3.medium"
    disk_size_gb  = 60
    ssh_key_name  = "instance-access-key" // manuall add key pair
    vpc_key       = "app"
    is_public     = false
  }
}


# ALB

albs = {
  app-nodejs = {
    backend_port = 8080
    vpc_key      = "app"
  }
  app-web = {
    backend_port = 8080
    vpc_key      = "app"
  }
}

# ACM

acms = {
  stage = {
    domain_names = [
      "*.stage.ipropertyexpress.com",
      "*.ipropertyexpress.com",
    ]
  }
}

# VPC

vpcs = {
  app = {
    azs = [
      "us-west-2a",
      "us-west-2b",
      "us-west-2c",
    ]
    cidr = "10.91.0.0/16"
    public_subnets = [
      "10.91.0.0/24",
      "10.91.1.0/24",
      "10.91.2.0/24",
    ]
    private_subnets = [
      "10.91.96.0/21",
      "10.91.104.0/21",
      "10.91.112.0/21",
    ]
  }
  mgt = {
    azs = [
      "us-west-2a",
      "us-west-2b",
      "us-west-2c",
    ]
    cidr = "10.21.0.0/16"
    public_subnets = [
      "10.21.0.0/24",
      "10.21.1.0/24",
      "10.21.2.0/24",
    ]
    private_subnets = [
      "10.21.96.0/21",
      "10.21.104.0/21",
      "10.21.112.0/21",
    ]
  }
}


acms = {
  stage = {
    domain_names = [
      "*.stage.ipropertyexpress.com",
      "*.ipropertyexpress.com",
    ]
  }
}

# ASG

asgs = {
  app = {
    image_id      = "ami-05d38da78ce859165" // Ubuntu 24.04 x86
    instance_type = "t3a.nano"
    disk_size_gb  = 20
  }
}

# S3 buckets

s3_buckets = {
  ipx_prod_backups = {
    bucket_name = "ipx.prod.backups"
    acl         = "private"
    lifecycle_rules = [
      {
        id         = "DB Backup.DeleteAfter7days"
        enabled    = true
        expiration = { days = 7 }
        transition = [] # 无 transition
        filter     = { prefix = "db.backups/" }
      },
      {
        id         = "db.storage.Del14Days"
        enabled    = true
        expiration = { days = 14 }
        transition = [] # 无 transition
        filter     = { prefix = "db.storage.backups/" }
      },
      {
        id         = "Glacier"
        enabled    = true
        expiration = null # 无 expiration
        transition = [
          { days = 2, storage_class = "DEEP_ARCHIVE" }
        ]
        filter     = { prefix = "Glacier/" }
      },
      {
        id         = "misc to one zone IA"
        enabled    = true
        expiration = null # 无 expiration
        transition = [
          { days = 30, storage_class = "ONEZONE_IA" }
        ]
        filter     = { prefix = "misc/" }
      }
    ]
  },
  ipx_prod_cldfiles = {
    bucket_name = "ipx.prod.cldfiles"
    acl         = "private"
    lifecycle_rules = [
      {
        id         = "TransitionToAI"
        enabled    = true
        expiration = null # 无 expiration
        transition = [
          { days = 30, storage_class = "STANDARD_IA" }
        ]
        filter     = {} # 无 prefix
      }
    ]
  },
  ipx_prod_sync = {
    bucket_name = "ipx.prod.sync"
    acl         = "private"
    lifecycle_rules = [
      {
        id         = "auto-delete-after-30-days"
        enabled    = true
        expiration = { days = 30 }
        transition = [] # 无 transition
        filter     = {} # 无 prefix
      }
    ]
  },
  ipx_prod_transit = {
    bucket_name = "ipx.prod.transit"
    acl         = "private"
    lifecycle_rules = [
      {
        id         = "auto-delete-after-200-days"
        enabled    = true
        expiration = { days = 200 }
        transition = [] # 无 transition
        filter     = {} # 无 prefix
      }
    ]
  },
  ipx_prod = {
    bucket_name = "ipx.prod"
    acl         = "private"
    lifecycle_rules = [
      {
        id         = "TransitionToAI2018"
        enabled    = true
        expiration = null # 无 expiration
        transition = [
          { days = 30, storage_class = "STANDARD_IA" }
        ]
        filter     = {} # 无 prefix
      },
      {
        id         = "sqs-delete"
        enabled    = true
        expiration = { days = 1 }
        transition = [] # 无 transition
        filter     = { prefix = "sqs/" }
      }
    ]
  },
  ipx_saleswebsite = {
    bucket_name = "ipx.saleswebsite"
    acl         = "private"
    lifecycle_rules = [
      {
        id         = "TransitionToAI2018"
        enabled    = true
        expiration = null # 无 expiration
        transition = [
          { days = 30, storage_class = "STANDARD_IA" }
        ]
        filter     = {} # 无 prefix
      }
    ]
  }
}


