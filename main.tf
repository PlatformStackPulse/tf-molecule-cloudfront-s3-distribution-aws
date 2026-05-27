# Molecule: CloudFront S3 Distribution with OAC
module "oac" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-cloudfront-oac-aws.git?ref=6f7ccaad2fbc85f14a02f2c27a34216ca5dc2f3f"

  context          = module.this.context
  origin_type      = "s3"
  signing_behavior = "always"
  description      = var.oac_description
}

module "cache_policy" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-cloudfront-cache-policy-aws.git?ref=9b6bd5b251dab14c709299b49aba2bbd55e7a77a"

  context               = module.this.context
  comment               = "Cache policy for S3 origin"
  default_ttl           = var.default_ttl
  max_ttl               = var.max_ttl
  min_ttl               = var.min_ttl
  cookie_behavior       = "none"
  header_behavior       = "none"
  query_string_behavior = "none"
  enable_gzip           = true
  enable_brotli         = true
}

module "distribution" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-cloudfront-distribution-aws.git?ref=d6df1a55bc3b6856dbb308cc848651776354b4ee"

  context              = module.this.context
  distribution_enabled = true
  default_root_object  = var.default_root_object
  aliases              = var.aliases
  price_class          = var.price_class
  web_acl_id           = var.web_acl_id
  acm_certificate_arn  = var.acm_certificate_arn

  origins = [{
    domain_name              = var.s3_bucket_regional_domain_name
    origin_id                = "s3-origin"
    origin_access_control_id = module.oac.id
  }]

  default_cache_behavior = {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = module.cache_policy.id
    compress               = true
  }

  depends_on = [module.oac, module.cache_policy]
}
