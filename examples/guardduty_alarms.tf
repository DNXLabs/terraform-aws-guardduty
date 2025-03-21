module "guardduty" {
  count  = local.workspace.guardduty.enabled ? 1 : 0
  source = "git::https://github.com/DNXLabs/terraform-aws-guardduty.git?ref=1.1.1"

  admin_account_id     = try(local.workspace.guardduty.admin_account_id, "")
  alarm_slack_severity = local.workspace.guardduty.alarms.enabled ? try(local.workspace.guardduty.alarms.alarm_slack_severity, "HIGH") : ""
  alarm_slack_webhook  = local.workspace.guardduty.alarms.enabled ? try(local.workspace.guardduty.alarms.slack_endpoints, []) : []
  lambda_name          = try(local.workspace.guardduty.lambda_name, "")
  sns_email_arn        = try(local.workspace.guardduty.sns_email_arn, "")
}
