module "shipping" {
  source               = "../../terraform-roboshop-app"
  centos_ami_id        = data.aws_ami.centos.id
  vpc_id               = data.aws_ssm_parameter.vpc_id.value
  subnet_ids           = data.aws_ssm_parameter.private_subnet_ids.value
  component_sg_id      = data.aws_ssm_parameter.shipping_sg_id.value
  iam_instance_profile = "role-for-workstation"
  centos_password      = data.aws_ssm_parameter.centos_password.value
  app_alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
  rule_priority        = 40

  tags = var.tags
}
