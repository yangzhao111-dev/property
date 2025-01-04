
resource "aws_iam_service_linked_role" "autoscaling" {
  aws_service_name = "autoscaling.amazonaws.com"
  description      = "A service linked role for autoscaling"
  custom_suffix    = "${var.name}-asg"

  # Sometimes good sleep is required to have some IAM resources created before they can be used
  provisioner "local-exec" {
    command = "sleep 10"
  }

  tags = merge(var.tags, local.tags)
}

resource "aws_iam_instance_profile" "ssm" {
  name = "${var.name}-asg-ssm"
  role = aws_iam_role.ssm.name

  tags = merge(var.tags, local.tags)
}

resource "aws_iam_role" "ssm" {
  name = "${var.name}-asg-ssm"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })

  tags = merge(var.tags, local.tags)
}
