variable "admin_account_id" {
  description = "GuardDuty Detector ID for master account"
}

variable "alarm_slack_webhook" {
  description = "Slack Incoming Web Hook URL. Leave blank to disable alarm to slack"
  default     = ""
}

variable "alarm_slack_severity" {
  default     = "HIGH"
  description = "Minimum severity level (LOW, MEDIUM, HIGH)"
}


variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = true
}

variable "lambda_name" {
  description = "Name of the Lambda Function"
}

variable "sns_email_arn" {
  description = "SNS Topic ARN"
  type        = string
  default     = ""
}
