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

# ASG

asgs = {
  app-nodejs = {
    image_id      = "ami-0e32864a4910bd3a9" // Ubuntu 24.04 x86
    instance_type = "t3a.medium"
    disk_size_gb  = 20
    ssh_key_name  = "instance-access-key" // manuall add key pair
    vpc_key       = "app"
    alb_key       = "app-nodejs"
  }
  app-web = {
    image_id      = "ami-0e32864a4910bd3a9" // Ubuntu 24.04 x86
    instance_type = "t3a.medium"
    disk_size_gb  = 20
    ssh_key_name  = "instance-access-key" // manuall add key pair
    vpc_key       = "app"
    alb_key       = "app-web"
  }
}
