# tf-molecule-cloudfront-s3-distribution-aws

CloudFront distribution with S3 origin, OAC, and cache policy.

## Usage

```hcl
module "cdn" {
  source = "git::https://github.com/PlatformStackPulse/tf-molecule-cloudfront-s3-distribution-aws.git?ref=v1.0.0"

  namespace   = "psp"
  environment = "prod"
  name        = "website"

  s3_bucket_regional_domain_name = module.bucket.bucket_regional_domain_name
  aliases                        = ["www.example.com"]
  acm_certificate_arn            = "arn:aws:acm:us-east-1:123456789012:certificate/abc"
}
```

<!-- BEGIN_TF_DOCS -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

### Providers

No providers.

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cache_policy"></a> [cache\_policy](#module\_cache\_policy) | git::https://github.com/PlatformStackPulse/tf-atom-cloudfront-cache-policy-aws.git | 9b6bd5b251dab14c709299b49aba2bbd55e7a77a |
| <a name="module_distribution"></a> [distribution](#module\_distribution) | git::https://github.com/PlatformStackPulse/tf-atom-cloudfront-distribution-aws.git | d6df1a55bc3b6856dbb308cc848651776354b4ee |
| <a name="module_oac"></a> [oac](#module\_oac) | git::https://github.com/PlatformStackPulse/tf-atom-cloudfront-oac-aws.git | 6f7ccaad2fbc85f14a02f2c27a34216ca5dc2f3f |
| <a name="module_this"></a> [this](#module\_this) | git::https://github.com/PlatformStackPulse/tf-label.git | v1.0.0 |

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_s3_bucket_regional_domain_name"></a> [s3\_bucket\_regional\_domain\_name](#input\_s3\_bucket\_regional\_domain\_name) | Regional domain name of the S3 bucket origin | `string` | n/a | yes |
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ACM certificate ARN for HTTPS | `string` | `null` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | CNAMEs (alternate domain names) for the distribution | `list(string)` | `[]` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br/>in the order they appear in the list. New attributes are appended to the<br/>end of the list. The elements of the list are joined by the `delimiter`<br/>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br/>See description of individual variables for details.<br/>Leave string and numeric variables as `null` to use default value.<br/>Individual variable settings (non-null) override settings in context object,<br/>except for attributes and tags, which are merged. | <pre>object({<br/>    enabled             = optional(bool, true)<br/>    namespace           = optional(string, null)<br/>    tenant              = optional(string, null)<br/>    environment         = optional(string, null)<br/>    stage               = optional(string, null)<br/>    name                = optional(string, null)<br/>    delimiter           = optional(string, null)<br/>    attributes          = optional(list(string), [])<br/>    tags                = optional(map(string), {})<br/>    label_order         = optional(list(string), null)<br/>    regex_replace_chars = optional(string, null)<br/>    id_length_limit     = optional(number, null)<br/>    label_key_case      = optional(string, null)<br/>    label_value_case    = optional(string, null)<br/>    labels_as_tags      = optional(set(string), null)<br/>    descriptor_formats = optional(map(object({<br/>      format = string<br/>      labels = list(string)<br/>    })), {})<br/>  })</pre> | `{}` | no |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | Default root object (e.g., index.html) | `string` | `"index.html"` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | Default TTL in seconds | `number` | `86400` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br/>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br/>Map of maps. Keys are names of descriptors. Values are maps of the form<br/>`{<br/>   format = string<br/>   labels = list(string)<br/>}`<br/>`format` is a Terraform format string to be passed to the `format()` function.<br/>`labels` is a list of labels, in order, to pass to `format()` function.<br/>Label values will be normalized before being passed to `format()` so they will be<br/>identical to how they appear in `id`.<br/>Default is `{}` (`descriptors` output will be empty). | <pre>map(object({<br/>    format = string<br/>    labels = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources. | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'. | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br/>Set to `0` for unlimited length.<br/>Set to `null` to keep the existing setting, which defaults to `0`.<br/>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br/>Does not affect keys of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper`.<br/>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br/>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br/>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br/>set as tag values, and output by this module individually.<br/>Does not affect values of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br/>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br/>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br/>Default is to include all labels.<br/>Tags with empty values will not be included in the `tags` output.<br/>Set to `[]` to suppress all generated tags.<br/>Note: The value of the `name` tag, if included, will be the `id`, not the `name`. | `set(string)` | `null` | no |
| <a name="input_max_ttl"></a> [max\_ttl](#input\_max\_ttl) | Maximum TTL in seconds | `number` | `31536000` | no |
| <a name="input_min_ttl"></a> [min\_ttl](#input\_min\_ttl) | Minimum TTL in seconds | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br/>This is the only ID element not also included as a `tag`.<br/>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique. | `string` | `null` | no |
| <a name="input_oac_description"></a> [oac\_description](#input\_oac\_description) | Description for the Origin Access Control | `string` | `"OAC for S3 origin"` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | CloudFront price class | `string` | `"PriceClass_100"` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br/>Characters matching the regex will be removed from the ID elements.<br/>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br/>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element. A customer identifier, indicating who this instance of a resource is for. | `string` | `null` | no |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | WAF Web ACL ID to associate | `string` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution_arn"></a> [distribution\_arn](#output\_distribution\_arn) | CloudFront distribution ARN |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | CloudFront distribution ID |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | CloudFront distribution domain name |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | Whether the module is enabled |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | CloudFront hosted zone ID for Route53 alias |
| <a name="output_oac_id"></a> [oac\_id](#output\_oac\_id) | Origin Access Control ID |
<!-- END_TF_DOCS -->
