# To provision a load balancer
# 1. Load Balancer
# 2. Listeners and rules
# 3. Create DNS record for the ALB DNS

# Provision a load balancer
resource "aws_lb" "app_alb" {
  name               = "${local.name}-${var.alb_tags.Component}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.app_alb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  tags = merge(
    var.common_tags,
    var.alb_tags
  )
}

# Add a listener with rule that returns fixed response
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi, this is from App ALB"
      status_code  = "200"
    }
  }
}