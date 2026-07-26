# -----------------------------------------------------------------------------
# Module-Specific Variables
#
# Note: Standard labeling variables (enabled, namespace, tenant, environment,
# stage, name, delimiter, attributes, tags, label_order, etc.) are provided
# by context.tf via the tf-label module.
# -----------------------------------------------------------------------------

variable "filter_name" {
  description = "Name of the subscription filter. Defaults to the tf-label id (module.this.id) when null."
  type        = string
  default     = null
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group to associate the subscription filter with."
  type        = string

  validation {
    condition     = length(var.log_group_name) > 0
    error_message = "log_group_name must be a non-empty string."
  }
}

variable "filter_pattern" {
  description = "Filter pattern for subscribing to a filtered stream of log events. Use \"\" to match all events."
  type        = string
  default     = ""
}

variable "destination_arn" {
  description = "ARN of the destination to deliver matching log events to (Lambda, Kinesis, or Firehose)."
  type        = string

  validation {
    condition     = length(var.destination_arn) > 0
    error_message = "destination_arn must be a non-empty string."
  }
}

variable "role_arn" {
  description = "ARN of an IAM role that grants CloudWatch Logs permission to deliver events to the destination. Required for Kinesis/Firehose."
  type        = string
  default     = null
}

variable "distribution" {
  description = "Method used to distribute log data to the destination: Random or ByLogStream."
  type        = string
  default     = null

  validation {
    condition     = var.distribution == null || contains(["Random", "ByLogStream"], coalesce(var.distribution, "Random"))
    error_message = "distribution must be one of: Random, ByLogStream (or null)."
  }
}
