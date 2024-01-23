module "alb" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for ALB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "app-alb"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}