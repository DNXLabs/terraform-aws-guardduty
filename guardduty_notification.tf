# output "guardduty_notification_lambda_output" {
#     value = aws_lambda_function.guardduty_notification_lambda[count.index].qualified_arn
#   }

#create a zip file of our source code (python) to deploy it into lambda
provider "archive" {}
data "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.module}/guardduty_notification.py"
  output_path = "${path.module}/guardduty_notification.zip"
}

data "aws_iam_policy_document" "guardduty_notification_trusted_policy" {
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "guardduty_notification_iam_role" {
  count              = var.enabled ? 1 : 0
  name               = "guardduty_notification_iam_role_lambda-${var.aws_region}"
  assume_role_policy = data.aws_iam_policy_document.guardduty_notification_trusted_policy.json
}

resource "aws_iam_policy" "guardduty_notification_lambda_logging_policy" {
  count       = var.enabled ? 1 : 0
  name        = "guardduty_notification_lambda_logging_policy-${var.aws_region}"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "sns:Publish",
        "kms:GenerateDataKey"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "guardduty_notification_attach_policy" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.guardduty_notification_iam_role[count.index].name
  policy_arn = aws_iam_policy.guardduty_notification_lambda_logging_policy[count.index].arn
}

resource "aws_lambda_function" "guardduty_notification_lambda" {
  count            = var.enabled ? 1 : 0
  function_name    = var.lambda_name
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  role             = aws_iam_role.guardduty_notification_iam_role[count.index].arn
  handler          = "guardduty_notification.lambda_handler-${var.aws_region}"
  runtime          = "python3.12"

  environment {
    variables = {
      event_threshold = "0"
      sns_email_arn   = var.sns_email_arn
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.guardduty_notification_attach_policy,
    aws_cloudwatch_log_group.guardduty_notification_log_group,
  ]
}

# This is to optionally manage the CloudWatch Log Group for the Lambda Function.
resource "aws_cloudwatch_log_group" "guardduty_notification_log_group" {
  count             = var.enabled ? 1 : 0
  name              = "/aws/lambda/${var.lambda_name}-${var.aws_region}"
  retention_in_days = 14
}

