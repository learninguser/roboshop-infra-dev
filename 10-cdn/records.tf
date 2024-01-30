module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "web-cdn"
      type    = "A"
      alias   = {
        name    = aws_cloudfront_distribution.learninguser.domain_name
        zone_id = aws_cloudfront_distribution.learninguser.hosted_zone_id
      }
    }
  ]
}