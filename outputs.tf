output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "id" {
  description = "The id (name) of the CloudWatch log subscription filter."
  value       = try(aws_cloudwatch_log_subscription_filter.this[0].id, null)
}
