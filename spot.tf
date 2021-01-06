resource "aws_spot_instance_request" "cheap_worker" {
  ami           = data.aws_ami.ami.id
  spot_price    = var.spot_price
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.aa.id]
}

variable "spot_price" {}
variable "instance_type" {}

data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "^Centos*"
  owners           = ["973714476881"]
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "aa" {
  name        = "aa-${random_id.server.hex}"
  description = "aa-${random_id.server.hex}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aa"
  }
}

resource "random_id" "server" {
  byte_length = 8
}