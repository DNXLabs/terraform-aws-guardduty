output "aws_sns_topic" {
  value = try(aws_sns_topic.default[0].arn, "")
}

output "aws_kms_key" {
  value = try(aws_kms_key.sns[0].id, "")
}