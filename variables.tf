variable "s3_bucket_regional_domain_name" {
  description = "Regional domain name of the S3 bucket origin"
  type        = string
}

variable "default_root_object" {
  description = "Default root object (e.g., index.html)"
  type        = string
  default     = "index.html"
}

variable "aliases" {
  description = "CNAMEs (alternate domain names) for the distribution"
  type        = list(string)
  default     = []
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "web_acl_id" {
  description = "WAF Web ACL ID to associate"
  type        = string
  default     = null
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
  default     = null
}

variable "oac_description" {
  description = "Description for the Origin Access Control"
  type        = string
  default     = "OAC for S3 origin"
}

variable "default_ttl" {
  description = "Default TTL in seconds"
  type        = number
  default     = 86400
}

variable "max_ttl" {
  description = "Maximum TTL in seconds"
  type        = number
  default     = 31536000
}

variable "min_ttl" {
  description = "Minimum TTL in seconds"
  type        = number
  default     = 0
}
