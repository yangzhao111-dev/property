data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:CreateBucket",
      "s3:PutBucketOwnershipControls",
      "s3:PutBucketPolicy",
      "s3:GetBucketVersioning",
      "s3:GetEncryptionConfiguration",
      "s3:GetBucketPolicy",
      "s3:GetBucketPublicAccessBlock",
      "s3:PutBucketVersioning",
      "s3:PutEncryptionConfiguration",
      "s3:PutBucketPublicAccessBlock"
    ]
    resources = [
      aws_s3_bucket.this.arn
    ]
    sid = "AllowAccessToTerraformStatesBucket"
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.this.arn}/*"
    ]
    sid = "AllowAccessToTerraformStatesFile"
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:CreateTable"
    ]
    resources = [
      aws_dynamodb_table.this.arn
    ]
    sid = "AllowAccessToTerraformStatesLockTable"
  }

  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    sid       = "AllowAssumeRole"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "this" {
  name   = "${local.deployer_user}Policy"
  policy = data.aws_iam_policy_document.this.json

  tags = merge(var.tags, local.tags)
}

resource "aws_iam_user" "this" {
  name = local.deployer_user

  tags = merge(var.tags, local.tags)
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}
