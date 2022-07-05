
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "eu-central-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-065deacbcaac64cf2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = file("init.sh")

  tags = {
    Name = "instance"
  }
}

resource "aws_security_group" "sg" {

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}