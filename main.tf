provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "default" {
  name        = "bibinSG3"
  description = "security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name = "bibinaws123"
  vpc_security_group_ids = [aws_security_group.default.id]


  tags = {
    Name = var.instance_name
  }
}



