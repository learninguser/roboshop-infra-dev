variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "sg_tags" {
  default = {}
}

variable "project_name" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}

variable "mongodb_sg_ingress_rules" {
  default = [
    {
      description = "Allow port 80"
      from_port   = 80 # 0 means all ports
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow port 443"
      from_port   = 443 # 0 means all ports
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "vpc_ingress_rules" {
  type = list(any)
  default = [
    {
      from_port   = 1179
      to_port     = 1179
      description = "Allow port 1179 to connect to openvpn "
      protocol    = "tcp"
      cidr_blocks = ["77.64.254.132/32"]
    },
    {
      from_port   = 22
      to_port     = 22
      description = "allowing PORT 22 from public"
      protocol    = "tcp"
      cidr_blocks = ["77.64.254.132/32"]
    }
  ]
}