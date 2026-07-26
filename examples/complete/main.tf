# -----------------------------------------------------------------------------
# Complete example: tf-atom-cloudwatch-log-subscription-filter-aws
# -----------------------------------------------------------------------------

provider "aws" {
  region = "eu-west-1"
}

module "log_subscription_filter" {
  source = "../../"

  namespace   = "eg"
  environment = "euw1"
  stage       = "app"
  name        = "errors"

  log_group_name  = "/aws/lambda/example"
  filter_pattern  = "ERROR"
  destination_arn = "arn:aws:lambda:eu-west-1:123456789012:function:log-processor"
}

output "filter_id" {
  description = "Id of the CloudWatch log subscription filter."
  value       = module.log_subscription_filter.id
}
