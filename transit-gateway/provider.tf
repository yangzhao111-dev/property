provider "aws" {
  region              = var.aws_region
  allowed_account_ids = ["${var.aws_account_id}"]

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/DeployerRole"
  }
}

provider "aws" {
  region              = local.peers.stage-us-app.region
  allowed_account_ids = ["${local.peers.stage-us-app.region}"]
  alias               = "peer-stage-us-app"

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/DeployerRole"
  }
}
