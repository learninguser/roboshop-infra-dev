# 1. Certificate creation
resource "aws_acm_certificate" "learninguser" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = merge(
    var.tags,
    var.common_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

# 2. Certificate validation

## a. Record Creation
resource "aws_route53_record" "learninguser" {
  for_each = {
    for dvo in aws_acm_certificate.learninguser.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 1
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone_id
}

## b. Record Validation
resource "aws_acm_certificate_validation" "learninguser" {
  certificate_arn         = aws_acm_certificate.learninguser.arn
  validation_record_fqdns = [for record in aws_route53_record.learninguser : record.fqdn]
}