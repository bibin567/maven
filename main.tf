provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "default" {
  name        = "bibinSG2"
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

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.default.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${var.key_pair_name}.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = ["sudo apt install openjdk-11-jdk"]
  }

  provisioner "file" {
    source      = "./my-project"
    destination = "./my-project"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install openjdk-11-jdk",
      "java -jar target/my-project-1.0-SNAPSHOT.jar"
    ]
  }

  tags = {
    Name = var.instance_name
  }
}
