# To provision a load balancer
# 1. Load Balancer
# 2. Listeners and rules
# 3. Create DNS record for the ALB DNS

# Provision a load balancer
resource "aws_lb" "web_alb" {
  name               = "${local.name}-${var.alb_tags.Component}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.web_alb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.public_subnet_ids.value)

  tags = merge(
    var.common_tags,
    var.alb_tags
  )
}

# Add a listener with rule that returns fixed response
resource "aws_lb_listener" "web_alb" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.aws_ssm_parameter.acm_certificate_arn.value

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi, this is from Web ALB using HTTPS"
      status_code  = "200"
    }
  }
}