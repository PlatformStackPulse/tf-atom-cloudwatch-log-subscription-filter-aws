# -----------------------------------------------------------------------------
# tf-atom-cloudwatch-log-subscription-filter-aws
#
# Single-resource atom: one aws_cloudwatch_log_subscription_filter, gated by the
# standard `enabled` flag from context.tf. This resource has no tags.
# -----------------------------------------------------------------------------

resource "aws_cloudwatch_log_subscription_filter" "this" {
  count = local.enabled ? 1 : 0

  name            = coalesce(var.filter_name, module.this.id)
  log_group_name  = var.log_group_name
  filter_pattern  = var.filter_pattern
  destination_arn = var.destination_arn
  role_arn        = var.role_arn
  distribution    = var.distribution
}
