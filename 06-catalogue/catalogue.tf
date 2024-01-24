# Steps for provisioning autoscaling

# 1. Create one instance
# 2. Provision with ansible/shell
# 3. Stop the instance
# 4. Take AMI
# 5. Delete the instance
# 6. Create launch template with AMI

# 1. Create one instance
module "catalogue" {
  source                              = "terraform-aws-modules/ec2-instance/aws"
  name                                = "${local.name}-${var.tags.Component}-ami"
  instance_type                       = "t3.micro"
  ami                                 = data.aws_ami.centos.id
  vpc_security_group_ids              = [data.aws_ssm_parameter.catalogue_sg_id.value]
  subnet_id                           = local.private_subnet_id
  create_spot_instance                = true
  spot_type                           = "persistent"
  spot_instance_interruption_behavior = "stop"

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name}-${var.tags.Component}-ami"
    },
    var.tags
  )
}

# 2. Provision with ansible/shell
resource "null_resource" "catalogue" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.catalogue.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host     = module.catalogue.private_ip
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
      "sudo sh /tmp/bootstrap.sh catalogue dev"
    ]
  }
}

# 3. Stop the instance
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = module.catalogue.id
  state       = "stopped"
  depends_on  = [null_resource.catalogue]
}

# 4. Take AMI
resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.name}-${var.tags.Component}-${local.current_time}"
  source_instance_id = module.catalogue.id
}

# 5. Delete the instance
resource "null_resource" "catalogue_delete" {
  triggers = {
    instance_id = module.catalogue.id
  }

  provisioner "local-exec" {
    command = [
      "aws ec2 cancel-spot-instance-requests --spot-instance-request-ids ${module.catalogue.spot_instance_id}",
      "aws ec2 terminate-instances --instance-ids ${module.catalogue.id}"
    ]
  }

  depends_on = [aws_ami_from_instance.catalogue]
}

# 6. Create launch template with AMI
resource "aws_launch_template" "catalogue" {
  name = "${local.name}-${var.tags.Component}"

  image_id                             = aws_ami_from_instance.catalogue.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  update_default_version               = true

  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.name}-${var.tags.Component}"
    }
  }
}
