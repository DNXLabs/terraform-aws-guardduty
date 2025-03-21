resource "random_string" "guardduty_alarm_slack_suffix" {
  count   = length(var.alarm_slack_webhook) > 0 ? length(var.alarm_slack_webhook) : 0
  length  = 8
  special = false
  lower   = true
  upper   = false
  number  = false
}

resource "aws_cloudformation_stack" "guardduty_alarm_slack" {
  count = length(var.alarm_slack_webhook) > 0 ? length(var.alarm_slack_webhook) : 0
  name  = "guardduty-alarm-slack-${random_string.guardduty_alarm_slack_suffix[count.index].result}"

  parameters = {
    IncomingWebHookURL = var.alarm_slack_webhook[count.index]
    MinSeverityLevel   = var.alarm_slack_severity
    NodejsVersion      = var.nodejs_version
  }

  template_body = file("${path.module}/guardduty-alarm-slack.cf.json")
  capabilities  = ["CAPABILITY_IAM"]
}
