module "ap-southeast-1" {
  providers = {
    "aws"        = "aws"
    "aws.master" = "aws.master"
  }

  source = "./guardduty-region"

  aws_region    = "ap-southeast-1"
  account_email = var.account_email
  master_id     = var.master_id
}

module "ap-southeast-2" {
  providers = {
    "aws"        = "aws"
    "aws.master" = "aws.master"
  }

  source = "./guardduty-region"

  aws_region    = "ap-southeast-2"
  account_email = var.account_email
  master_id     = var.master_id
}
