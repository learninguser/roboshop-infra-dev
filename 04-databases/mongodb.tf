module "mongodb" {
  source                              = "terraform-aws-modules/ec2-instance/aws"
  name                                = "${local.ec2_name}-mongodb"
  instance_type                       = "t3.micro"
  ami                                 = data.aws_ami.centos.id
  vpc_security_group_ids              = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id                           = local.database_subnet_id
  create_spot_instance                = true
  spot_type                           = "persistent"
  spot_instance_interruption_behavior = "stop"

  tags = merge(
    var.common_tags,
    {
      Name = "${local.ec2_name}-mongodb"
    },
    {
      Component = "mongodb"
    }
  )
}

resource "null_resource" "mongodb" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.mongodb.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host     = module.mongodb.private_ip
    type     = "ssh"
    user     = "centos"
    password = data.aws_ssm_parameter.centos_password.value
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sudo chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb dev"
    ]
  }
}
