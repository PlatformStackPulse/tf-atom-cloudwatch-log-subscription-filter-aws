mock_provider "aws" {}

# Standard tf-label inputs shared by every run block below.
variables {
  namespace       = "eg"
  stage           = "test"
  name            = "thing"
  log_group_name  = "/aws/lambda/example"
  destination_arn = "arn:aws:lambda:eu-west-1:123456789012:function:log-processor"
}

run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should report enabled = true when enabled is left at its default."
  }

  assert {
    condition     = length(aws_cloudwatch_log_subscription_filter.this) == 1
    error_message = "Exactly one aws_cloudwatch_log_subscription_filter should be planned when enabled."
  }

  assert {
    condition     = aws_cloudwatch_log_subscription_filter.this[0].name == "eg-test-thing"
    error_message = "Filter name should default to the tf-label id."
  }
}

run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled = false when enabled = false is passed."
  }

  assert {
    condition     = length(aws_cloudwatch_log_subscription_filter.this) == 0
    error_message = "No aws_cloudwatch_log_subscription_filter should be planned when disabled."
  }

  assert {
    condition     = output.id == null
    error_message = "id output should be null when the module is disabled."
  }
}
