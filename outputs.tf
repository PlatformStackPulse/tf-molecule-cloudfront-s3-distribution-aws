output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.distribution.id
}

output "distribution_arn" {
  description = "CloudFront distribution ARN"
  value       = module.distribution.arn
}

output "domain_name" {
  description = "CloudFront distribution domain name"
  value       = module.distribution.domain_name
}

output "hosted_zone_id" {
  description = "CloudFront hosted zone ID for Route53 alias"
  value       = module.distribution.hosted_zone_id
}

output "oac_id" {
  description = "Origin Access Control ID"
  value       = module.oac.id
}
