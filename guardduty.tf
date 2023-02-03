resource "aws_guardduty_detector" "member" {
  count = var.enable_detector ? 1 : 0
  enable = var.enable_detector
}

resource "aws_guardduty_invite_accepter" "member" {
  # detector_id       = try(aws_guardduty_detector.member.id, var.member_detector_id)
  detector_id       = var.member_detector_id
  master_account_id = var.admin_account_id
}
