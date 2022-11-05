
resource "aws_cloudwatch_event_rule" "guardduty_notification_rule" {
  count         = var.enabled ? 1 : 0
  name          = "guardduty-finding-events"
  description   = "AWS GuardDuty event findings"
  event_pattern = file("${path.module}/event-pattern.json")
}


resource "aws_cloudwatch_event_target" "guardduty_notification_target_event" {
  count     = var.enabled ? 1 : 0
  rule      = aws_cloudwatch_event_rule.guardduty_notification_rule[count.index].name
  target_id = "send-to-sns-slack"
  arn       = aws_lambda_function.guardduty_notification_lambda[count.index].arn

  depends_on = [
    aws_lambda_function.guardduty_notification_lambda,
    aws_cloudwatch_event_rule.guardduty_notification_rule,
  ]
}

resource "aws_lambda_permission" "allow_guardduty_notification_trigger" {
  count         = var.enabled ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.guardduty_notification_lambda[count.index].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.guardduty_notification_rule[count.index].arn

  depends_on = [
    aws_cloudwatch_event_rule.guardduty_notification_rule,
  ]

}
