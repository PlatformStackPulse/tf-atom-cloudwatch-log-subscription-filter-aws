variable "log_group_name" {
  description = "Name of the log group to subscribe to"
  type        = string
  validation {
    condition     = length(var.log_group_name) > 0
    error_message = "log_group_name must not be empty."
  }
}

variable "filter_pattern" {
  description = "Filter pattern for log events (empty string for all)"
  type        = string
  default     = ""
}

variable "destination_arn" {
  description = "ARN of the destination (Lambda, Kinesis, Firehose)"
  type        = string
  validation {
    condition     = length(var.destination_arn) > 0
    error_message = "destination_arn must not be empty."
  }
}

variable "role_arn" {
  description = "IAM role ARN for the subscription (required for Kinesis)"
  type        = string
  default     = null
}
