# Base

country        = "us"
environment    = "stage"
aws_account_id = "539247459406"
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

# ALB

albs = {
  app = {
    backend_port = 8080
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

# ASG

asgs = {
  app = {
    image_id      = "ami-05d38da78ce859165" // Ubuntu 24.04 x86
    instance_type = "t3a.nano"
    disk_size_gb  = 20
  }
}
