module "mongodb" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for MongoDB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "mongodb"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "redis" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for redis"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "redis"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "mysql" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for mysql"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "mysql"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "rabbitmq" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for rabbitmq"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "rabbitmq"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "catalogue" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for catalogue"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "catalogue"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "user" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for user"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "user"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "cart" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for cart"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "cart"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "shipping" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for shipping"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "shipping"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "payment" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for payment"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "payment"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "web" {
  source         = "git::https://github.com/learninguser/terraform-aws-sg.git?ref=master"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for web"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "web"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}
