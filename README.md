# terraform-aws-guardduty

[![Lint Status](https://github.com/DNXLabs/terraform-aws-guardduty/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-guardduty/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-guardduty)](https://github.com/DNXLabs/terraform-aws-guardduty/blob/master/LICENSE)

This module creates the "member" side of Guardduty, with the assumption that there will be a admin_account responsible for sending an invite to the member.

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_account\_id | GuardDuty Detector ID for master account | `any` | n/a | yes |
| alarm\_slack\_severity | Minimum severity level (LOW, MEDIUM, HIGH) | `string` | `"HIGH"` | no |
| alarm\_slack\_webhook | Slack Incoming Web Hook URL. Leave blank to disable alarm to slack | `string` | `""` | no |
| enabled | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| lambda\_name | Name of the Lambda Function | `any` | n/a | yes |
| sns\_email\_arn | SNS Topic ARN | `string` | `""` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Author

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-guardduty/blob/master/LICENSE) for full details.
