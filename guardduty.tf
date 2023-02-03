resource "aws_guardduty_detector" "member" {
  count = var.enable_detector ? 1 : 0

  enable = var.enable_detector
}

resource "aws_guardduty_invite_accepter" "member" {
  count = var.create_invite_accepter ? 1 : 0

  detector_id       = try(aws_guardduty_detector.member.id, var.member_detector_id)
  master_account_id = var.admin_account_id
}
