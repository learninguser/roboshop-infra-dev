module "payment" {
  source               = "git::https://github.com/learninguser/terraform-roboshop-app.git?ref=master"
  centos_ami_id        = data.aws_ami.centos.id
  vpc_id               = data.aws_ssm_parameter.vpc_id.value
  subnet_ids           = data.aws_ssm_parameter.private_subnet_ids.value
  component_sg_id      = data.aws_ssm_parameter.payment_sg_id.value
  iam_instance_profile = "role-for-workstation"
  centos_password      = data.aws_ssm_parameter.centos_password.value
  app_alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
  rule_priority        = 50

  tags = var.tags
}
