provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "default" {
  name        = "bibinSG1"
  description = "security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_key_pair" "bibinjava" {
  key_name   = "bibinjava"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCi0223ntkJS+zps//Ysmvo0HErbK/ZtxRPN77xNsaejmFYIMxMuP8lemzyPY/QGMszp8zkEOl13/DFH+Ju3DnccuAWcEK5u3x4WgK7AnK0aLcACzWC0ED0rtjNywRpSjOuV+KZn1xpZhren7PEMyWe9U0Lnq9couIXEIl8EOArmnGiVaZeqv7XC951KSk9m7NDHPTOPRbC5bg3xO8jacZPZ8ib1nSbivi/lzMgE96RQKq3kVwa94pnc/wx4t51xdxws/hxCvjySKvYmYpkUsbbYVvUCo2EgWSUefhMxt3Pezma8Ax+nRZ5tRkvwHg6Ioz/keHBxC7s90JDQwhkt/KS0w8HYX7vuhdMZ7elW1vuwJhiaeebdDsxKDTTQdZpsysW9JMASj0qDQgMC9f4MXYHb+gHLEE+H9N1DQ4wJPNyUU3lMhdEBhvmrCJyiZJ1Dpm9fuMbCZqg+12El5WNmKzfBkevghEWSgmsrJDMtGA6bRib+UQaVhPazy7kii0X2ss= bibin.joy@AMAGVG497G09Y"
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.bibinjava.key_name
  vpc_security_group_ids = [aws_security_group.default.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)  # Update to use the variable
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install openjdk-11-jdk",
      "sudo java -jar ./my-project-1.0-SNAPSHOT.jar"
    ]
  }

  tags = {
    Name = var.instance_name
  }
}

variable "private_key_path" {
  description = "Path to the private key file"
  type        = string
}

