variable "master_id" {}

variable "account_email" {}

variable "aws_region" {}

provider "aws" {
  region = "${var.aws_region}"
}

provider "aws" {
  alias = "master"
}

resource "aws_guardduty_detector" "member" {}

resource "aws_guardduty_member" "account" {
  provider = "aws.master"

  account_id                 = "${aws_guardduty_detector.member.*.account_id[0]}"
  detector_id                = "${var.master_id}"
  email                      = "${var.account_email}"
  invite                     = true
  disable_email_notification = true
}

data "aws_caller_identity" "master" {
  provider = "aws.master"
}

resource "aws_guardduty_invite_accepter" "member" {
  depends_on = ["aws_guardduty_member.account"]

  detector_id       = "${aws_guardduty_detector.member.*.id[0]}"
  master_account_id = "${data.aws_caller_identity.master.account_id}"
}
