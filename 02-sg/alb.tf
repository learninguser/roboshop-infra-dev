module "app_alb" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for ALB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "app-alb"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

# App ALB should accept connections only from VPN since its internal
resource "aws_security_group_rule" "app_alb_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

# Web ALB
module "web_alb" {
  source         = "../../terraform-aws-sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for ALB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "web-alb"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

# web ALB should accept connections from anywhere
resource "aws_security_group_rule" "web_alb_internet" {
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = module.web_alb.sg_id
}

# App ALB should accept connections from Web
resource "aws_security_group_rule" "app_alb_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}


resource "aws_security_group_rule" "app_alb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}


resource "aws_security_group_rule" "app_alb_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}


resource "aws_security_group_rule" "app_alb_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}


resource "aws_security_group_rule" "app_alb_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}
