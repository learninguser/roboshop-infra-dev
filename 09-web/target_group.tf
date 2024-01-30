resource "aws_lb_target_group" "catalogue" {
  name                 = "${local.name}-${var.tags.Component}"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = data.aws_ssm_parameter.vpc_id.value
  deregistration_delay = 60

  health_check {
    path                = "/health"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 10
    matcher             = "200-299" # has to be HTTP 200-299 or fail
  }
}
