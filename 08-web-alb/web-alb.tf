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
    var.tags
  )
}