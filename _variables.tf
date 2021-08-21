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
