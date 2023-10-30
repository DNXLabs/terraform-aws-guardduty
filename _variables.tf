variable "admin_account_id" {
  description = "GuardDuty Detector ID for master account"
  type        = string
}

variable "alarm_slack_webhook" {
  description = "Slack Incoming Web Hook URL. Leave blank to disable alarm to slack"
  type        = string
  default     = ""
}

variable "alarm_slack_severity" {
  description = "Minimum severity level (LOW, MEDIUM, HIGH)"
  type        = string
  default     = "HIGH"
}


variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "lambda_name" {
  type        = string
  description = "Name of the Lambda Function"
}

variable "sns_email_arn" {
  description = "SNS Topic ARN"
  type        = string
  default     = ""
}

variable "enable_detector" {
  description = "Enable GuardDuty Member Detector"
  type        = bool
  default     = true
}

variable "create_invite_accepter" {
  description = "Create GuardDuty Member Invite Accepter. Not needed if already setup as part of an organization"
  type        = bool
  default     = true
}

variable "member_detector_id" {
  description = "GuardDuty Detector ID for member account. Only needed if enable_detector is false. Used for targeting any previously enable detector"
  type        = string
  default     = ""
}

variable "nodejs_version" {
  type        = string
  default     = "nodejs18.x"
  description = "Version of Nodejs to create the lambda"
}
