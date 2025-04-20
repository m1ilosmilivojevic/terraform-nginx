# main.tf
provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "ubuntu_ec2" {
  ami                    = "ami-0c1ac8a41498c1a9c" # Ubuntu AMI for eu-north-1
  instance_type          = "t3.micro"
  key_name               = "miles-key2"  # optional: if you want to SSH in
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  user_data              = file("init.sh")
  tags = {
    Name = "MilesEC2"
  }
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP"

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

resource "aws_eip" "miles_eip" {
  instance = aws_instance.ubuntu_ec2.id
  domain      = "vpc"
}
