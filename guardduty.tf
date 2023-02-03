resource "aws_guardduty_detector" "member" {
  enable = var.enable_detector
}

resource "aws_guardduty_invite_accepter" "member" {
  detector_id       = try(aws_guardduty_detector.member.id, var.member_detector_id)
  master_account_id = var.admin_account_id
}
