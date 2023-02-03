resource "aws_guardduty_detector" "member" {
  enable = var.enable_detector
}

resource "aws_guardduty_invite_accepter" "member" {
  detector_id       = try(aws_guardduty_detector.member.id, data.aws_guardduty_detector.member.id)
  master_account_id = var.admin_account_id
}
