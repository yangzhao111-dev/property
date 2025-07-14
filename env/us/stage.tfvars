# Base

country        = "us"
environment    = "stage"
aws_account_id = "922456365681"
aws_region     = "us-west-2"

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
    ],
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
    ],
  }
}

# ASG

asgs = {
  app-nodejs = {
    image_id      = "ami-0e32864a4910bd3a9" // Windows 2025
    instance_type = "t3.medium"
    disk_size_gb  = 30
    ssh_key_name  = "instance-access-key" // manuall add key pair
    vpc_key       = "app"
    alb_key       = "app-nodejs"

    name             = "app-nodejs-prod"
    min_size         = 1
    max_size         = 20
    desired_capacity = 7

    scaling_policies = {
      scale_up = {
        policy_name               = "scale-up-app-nodejs-prod-asg"
        policy_type               = "StepScaling"
        enabled                   = true
        alarm_name                = "TargetTracking-app-nodejs-prod-asg-AlarmHigh"
        metric_name               = "CPUUtilization"
        threshold                 = 70
        adjustment_type           = "ChangeInCapacity"
        scaling_adjustment        = 1
        estimated_instance_warmup = 180
        evaluation_periods        = 5
        period                    = 60
        comparison_operator       = "GreaterThanOrEqualToThreshold"
      },
      scale_down = {
        policy_name         = "scale-down-app-nodejs-prod-asg"
        policy_type         = "StepScaling"
        enabled             = true
        alarm_name          = "TargetTracking-app-nodejs-prod-asg-AlarmLow"
        metric_name         = "CPUUtilization"
        threshold           = 45
        adjustment_type     = "ChangeInCapacity"
        scaling_adjustment  = -1
        evaluation_periods  = 16
        period              = 60
        comparison_operator = "LessThanOrEqualToThreshold"
      }
    }
  }

  app-web = {
    image_id      = "ami-0e32864a4910bd3a9" // Windows 2025
    instance_type = "t3.medium"
    disk_size_gb  = 30
    ssh_key_name  = "instance-access-key" // manuall add key pair
    vpc_key       = "app"
    alb_key       = "app-web"

    name             = "app-web-prod"
    min_size         = 2
    max_size         = 30
    desired_capacity = 3

    scaling_policies = {
      scale_up = {
        policy_name               = "scale-up-app-web-prod-asg"
        policy_type               = "StepScaling"
        enabled                   = true
        alarm_name                = "TargetTracking-app-web-prod-asg-AlarmHigh"
        metric_name               = "CPUUtilization"
        threshold                 = 76
        adjustment_type           = "ChangeInCapacity"
        scaling_adjustment        = 1
        estimated_instance_warmup = 180
        evaluation_periods        = 5
        period                    = 60
        comparison_operator       = "GreaterThanThreshold"
      },
      scale_dow = {
        policy_name         = "scale-down-app-web-prod-asg"
        policy_type         = "StepScaling"
        enabled             = true
        alarm_name          = "TargetTracking-app-web-prod-asg-AlarmLow"
        metric_name         = "CPUUtilization"
        threshold           = 46
        adjustment_type     = "ChangeInCapacity"
        scaling_adjustment  = -1
        evaluation_periods  = 16
        period              = 60
        comparison_operator = "LessThanOrEqualToThreshold"
      }
    }
  }
}

#EC2

ec2s = {
  app-bastion = {
    image_id      = "ami-0e32864a4910bd3a9" // Windows 2025
    instance_type = "t3.micro"
    
    #root block device: object
    root_block_device = {
      encrypted   = true
      volume_type = "gp3"
      volume_size = 70
      throughput  = 125
      iops        = 3000
    }
    extra_disks  = []
    ssh_key_name = "instance-access-key" // manuall add key pair
    vpc_key      = "mgt"
    is_public    = true
    security_group_ingress_cidr_rules = [
      {
        description = "Michael home"
        cidr_block  = "106.71.18.220/32"
        port        = 3389
      },
      {
        description = "Jeff on the go"
        cidr_block  = "1.145.95.24/32"
        port        = 3389
      },
      {
        description = "Kaijun Home"
        cidr_block  = "49.176.239.94/32"
        port        = 3389
      },
      {
        description = "Jeff home (cheadle)"
        cidr_block  = "101.181.86.108/32"
        port        = 3389
      },
      {
        description = "JK Home 2 (rose)"
        cidr_block  = "144.132.239.218/32"
        port        = 3389
      },
      {
        description = "ML"
        cidr_block  = "61.69.159.127/32"
        port        = 3389
      },
      {
        description = "Unlabeled IP"
        cidr_block  = "203.45.19.80/32"
        port        = 3389
      },
      {
        description = "good"
        cidr_block  = "13.211.109.81/32"
        port        = 3389
      },
    ]
  }
  rds = {
    image_id      = "ami-0e32864a4910bd3a9" // Windows 2025
    instance_type = "t3.medium"
    root_block_device = {
      encrypted   = true
      volume_type = "gp3"
      volume_size = 600
      throughput  = 600
      iops        = 3000
    }
    ssh_key_name = "instance-access-key" // manuall add key pair
    ebs_volumes = {
      xvdf = {   // new name
        encrypted   = true
        device_name = "xvdf"
        type = "gp3"
        size        = 600
        throughput  = 600
        iops        = 3000
      },
      xvdb = {
        encrypted   = true
        device_name = "xvdb"
        type        = "gp3"
        size        = 2500
        throughput  = 600
        iops        = 3000
      }
    }
    vpc_key   = "app"
    is_public = false
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

/*
acms = {
  stage = {
    domain_names = [
      "*.stage.ipropertyexpress.com",
      "*.ipropertyexpress.com",
    ]
  }
}
*/

# S3 buckets

s3_buckets = {
  backups = {
    bucket_name              = "backups"
    control_object_ownership = true
    object_ownership         = "ObjectWriter"
    acl                      = "private"
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
        filter = { prefix = "Glacier/" }
      },
      {
        id         = "misc to one zone IA"
        enabled    = true
        expiration = null # 无 expiration
        transition = [
          { days = 30, storage_class = "ONEZONE_IA" }
        ]
        filter = { prefix = "misc/" }
      }
    ]
  },
  cldfiles = {
    bucket_name              = "cldfiles"
    control_object_ownership = true
    object_ownership         = "ObjectWriter"
    acl                      = "private"
    lifecycle_rules = [
      {
        id         = "TransitionToAI"
        enabled    = true
        expiration = null # 无 expiration
        transition = [
          { days = 30, storage_class = "STANDARD_IA" }
        ]
        filter = {} # 无 prefix
      }
    ]
  },
  sync = {
    bucket_name              = "sync"
    control_object_ownership = true
    object_ownership         = "ObjectWriter"
    acl                      = "private"
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
  transit = {
    bucket_name              = "transit"
    control_object_ownership = true
    object_ownership         = "ObjectWriter"
    acl                      = "private"
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
  main = {
    bucket_name              = "main"
    control_object_ownership = true
    object_ownership         = "ObjectWriter"
    acl                      = "private"
    lifecycle_rules = [
      {
        id         = "TransitionToAI2018"
        enabled    = true
        expiration = null # 无 expiration
        transition = [
          { days = 30, storage_class = "STANDARD_IA" }
        ]
        filter = {} # 无 prefix
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
  saleswebsite = {
    bucket_name              = "saleswebsite"
    control_object_ownership = true
    object_ownership         = "ObjectWriter"
    acl                      = "private"
    lifecycle_rules = [
      {
        id         = "TransitionToAI2018"
        enabled    = true
        expiration = null # 无 expiration
        transition = [
          { days = 30, storage_class = "STANDARD_IA" }
        ]
        filter = {} # 无 prefix
      }
    ]
  }
}

# tgw

tgw = {
  amazon_side_asn             = 4200010001
  transit_gateway_cidr_blocks = ["10.99.0.0/24"]
}

// key is VPC key
tgw_attached_vpcs = {
  mgt = {
    tgw_routes = [
      {
        destination_cidr_block = "10.91.0.0/16"
      },
    ]
  }
  app = {
    tgw_routes = [
      {
        destination_cidr_block = "10.21.0.0/16"
      },
    ]
  }
}


// key is VPC key
extra_route_tables_for_tgw = {
  # mgt = {
  #   # cidrs = [
  #   #   "10.91.0.0/16",
  #   # ]
  # },
  # app = {
  #   # cidrs = [
  #   #   "10.21.0.0/16",
  #   # ]
  # },
}
