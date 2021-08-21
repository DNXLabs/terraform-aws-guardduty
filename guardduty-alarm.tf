resource "random_string" "guardduty_alarm_slack_suffix" {
  count   = var.alarm_slack_webhook == "" ? 0 : 1
  length  = 8
  special = false
  lower   = true
  upper   = false
  number  = false
}

resource "aws_cloudformation_stack" "guardduty_alarm_slack" {
  count = var.alarm_slack_webhook == "" ? 0 : 1
  name  = "guardduty-alarm-slack-${random_string.guardduty_alarm_slack_suffix[0].result}"

  parameters = {
    IncomingWebHookURL = var.alarm_slack_webhook
    MinSeverityLevel   = var.alarm_slack_severity
  }

  template_body = file("${path.module}/guardduty-alarm-slack.cf.json")
  capabilities  = ["CAPABILITY_IAM"]
}
