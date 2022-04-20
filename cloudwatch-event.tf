resource "aws_cloudwatch_event_rule" "guardduty" {
  count       = var.sns_topic_name != "" ? 1 : 0
  name        = "guardduty-events"
  description = "GuardDutyEvent"
  #   is_enabled  = var.guardduty_enabled
  #   tags        = var.tags
  event_pattern = var.event_pattern
}

resource "aws_cloudwatch_event_target" "guardduty" {
  count     = var.sns_topic_name != "" ? 1 : 0
  rule      = aws_cloudwatch_event_rule.guardduty[0].name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.default[0].arn
  input_transformer {
    input_paths = {
      "Account_ID" : "$.detail.accountId",
      "Finding_ID" : "$.detail.id",
      "Finding_Type" : "$.detail.type",
      "Finding_description" : "$.detail.description",
      "region" : "$.region",
      "severity" : "$.detail.severity"
    }

    input_template = <<INPUT_TEMPLATE_EOF
      "AWS <Account_ID> has a severity <severity> GuardDuty finding type <Finding_Type> in the <region> region."
      "Finding Description:"
      "<Finding_description>. "
      "For more details open the GuardDuty console at https://console.aws.amazon.com/guardduty/home?region=<region>#/findings?search=id=<Finding_ID>"
    INPUT_TEMPLATE_EOF
  }
}



