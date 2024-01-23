module "ec2_instance" {
  source                              = "terraform-aws-modules/ec2-instance/aws"
  name                                = "${local.ec2_name}-vpn"
  instance_type                       = "t3.micro"
  ami                                 = data.aws_ami.centos.id
  vpc_security_group_ids              = [data.aws_ssm_parameter.openvpn.value]
  subnet_id                           = data.aws_subnet.default.id
  create_spot_instance                = true
  spot_type                           = "persistent"
  spot_instance_interruption_behavior = "stop"
  user_data                           = file("openvpn.sh")

  tags = merge(
    var.common_tags,
    {
      Component = "vpn"
    }
  )
}
