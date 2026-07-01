# Unit Tests — tf-atom-cloudwatch-log-subscription-filter-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
#
# Assertions are made only on plan-KNOWN values (tf-label id string,
# input pass-throughs, the `enabled` flag). Computed arn/id attributes are
# unknown under a mock provider and are therefore NOT asserted here.

mock_provider "aws" {}

# Standard tf-label inputs applied to every run below.
variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"
}

# ---------------------------------------------------------------------------
# Test: module is active when enabled = true (the default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should report enabled = true when the enabled input defaults to true."
  }

  assert {
    condition     = module.this.id == "eg-test-thing"
    error_message = "tf-label id should be composed as namespace-stage-name (eg-test-thing)."
  }

  assert {
    condition     = module.this.namespace == "eg"
    error_message = "namespace should pass through to the tf-label context unchanged."
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when enabled = false
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled = false when the enabled input is false."
  }
}
