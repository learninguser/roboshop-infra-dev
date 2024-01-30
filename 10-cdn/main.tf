resource "aws_cloudfront_distribution" "learninguser" {
  enabled = true
  aliases = ["web-${var.tags.Component}.${var.domain_name}"]
  origin {
    domain_name = "web-${var.environment}.${var.domain_name}"
    origin_id   = "web-${var.environment}.${var.domain_name}"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = "web-${var.environment}.${var.domain_name}"
    viewer_protocol_policy = "https-only"
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN", "US", "CA"]
    }
  }
  tags = merge(var.tags, var.common_tags)
  viewer_certificate {
    acm_certificate_arn      = data.aws_ssm_parameter.acm_certificate_arn.value
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
