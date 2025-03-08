# https://registry.terraform.io/modules/terraform-aws-modules/autoscaling/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-autoscaling
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 8.0"

  # Autoscaling group
  name            = "${var.name}-asg"
  use_name_prefix = false
  instance_name   = var.instance_name

  ignore_desired_capacity_changes = true

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  default_instance_warmup   = 300
  health_check_type         = "EC2"
  vpc_zone_identifier       = var.private_subnets
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn

  scaling_policies   = var.scaling_policies

  # Traffic source attachment
  traffic_source_attachments = {
    ex-alb = {
      traffic_source_identifier = var.target_group_arn
      traffic_source_type       = "elbv2" # default
    }
  }

  iam_instance_profile_arn = aws_iam_instance_profile.ssm.arn

  instance_maintenance_policy = {
    min_healthy_percentage = 100
    max_healthy_percentage = 110
  }

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
      max_healthy_percentage = 100
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "${var.name}-asg-lt"
  launch_template_description = "Launch template for ${var.name}"
  update_default_version      = true

  image_id          = var.image_id
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = true

  # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = "${var.name}-asg-node"
  iam_role_use_name_prefix    = false
  iam_role_path               = "/ec2/"
  iam_role_description        = "IAM role for ASG node ${var.name}"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  block_device_mappings = [
    {
      device_name = "/dev/sda1"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.disk_size_gb
        volume_type           = "gp3"
      }
    }
  ]

  security_groups = [aws_security_group.this.id]
  key_name        = local.ssh_key_name

  tags = merge(var.tags, local.tags)
}
