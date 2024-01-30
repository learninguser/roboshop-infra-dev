resource "aws_ssm_parameter" "web_alb_listener_arn" {
    name = "/${var.project_name}/${var.environment}/web_alb_listener_arn"
    type = "String"
    value = aws_lb_listener.web_alb.arn
}

resource "aws_ssm_parameter" "web_alb_dns_name" {
    name = "/${var.project_name}/${var.environment}/web_alb_dns_name"
    type = "String"
    value = aws_lb.web_alb.dns_name
}