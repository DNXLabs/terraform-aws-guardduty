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

# variable "notification_arn" {
#   description = "SNS Topic to send notifications to"
#   type        = string
# }

variable "email" {
  default     = ""
  description = "Email address to subscribe notification to (optional)"
}

variable "event_pattern" {
  default     = ""
  description = "Event pattern"
}

variable "sns_topic_name" {
  description = "Topic name (optional - creates SNS topic)"
  default     = ""
}

variable "sns_topic_arn" {
  description = "SNS Topic to use instead of creating one (optional)"
  default     = ""
}

variable "account_ids" {
  type        = list(string)
  default     = []
  description = "List of accounts to allow publishing to SNS (optional - only when SNS topic is created)"
}

variable "sns_kms_encryption" {
  type        = bool
  default     = false
  description = "Enabled KMS CMK encryption at rest for SNS Topic"
}