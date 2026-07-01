# Unit Tests — tf-molecule-cloudfront-s3-distribution-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Assertions target plan-KNOWN values (tf-label id, input pass-throughs,
# the `enabled` flag) rather than computed CloudFront arn/id which are
# unknown under a mock provider.
#
# Run:         terraform test -test-directory=tests/unit
# Run verbose: terraform test -test-directory=tests/unit -verbose

mock_provider "aws" {}

variables {
  # tf-label identity
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # module-required input
  s3_bucket_regional_domain_name = "eg-test-thing.s3.us-east-1.amazonaws.com"

  # optional inputs with valid sample values
  aliases             = ["www.example.com"]
  acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
}

# ---------------------------------------------------------------------------
# Test: module is enabled by default and produces a consistent identity
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default"
  }

  assert {
    condition     = module.this.id == "eg-test-thing"
    error_message = "tf-label id should be 'eg-test-thing' for namespace=eg, stage=test, name=thing"
  }

  assert {
    condition     = module.this.namespace == "eg"
    error_message = "tf-label namespace should propagate as 'eg'"
  }
}

# ---------------------------------------------------------------------------
# Test: enabled = false short-circuits the module
# ---------------------------------------------------------------------------
run "disabled_short_circuits" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled == false when enabled input is false"
  }
}
