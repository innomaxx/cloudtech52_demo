
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "eu-central-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-065deacbcaac64cf2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  availability_zone      = data.aws_ebs_volume.ebs_volume.availability_zone

  user_data              = <<-EOF
     #!/bin/bash
     curl -fsSL https://get.docker.com -o get-docker.sh
     sudo sh get-docker.sh
     mkdir app && cd app
     git clone https://github.com/innomaxx/cloudtech52_demo.git .
     git checkout feature/hide_creds
     echo DB_HOST=\${var.db_host} >> .env
     echo DB_NAME=\${var.db_name} >> .env
     echo DB_USER=\${var.db_user} >> .env
     echo DB_PASS="${var.db_pass}" >> .env
     sudo docker compose -f "docker-compose.prod.yml" up -d
  EOF

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
    from_port   = 3001
    protocol    = "tcp"
    to_port     = 3001
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3002
    protocol    = "tcp"
    to_port     = 3002
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.app_server.id
  allocation_id = var.aws_eip_alloc_id
}

resource "aws_volume_attachment" "ext_storage" {
  volume_id   = var.aws_ebs_volume_id
  instance_id = aws_instance.app_server.id
  device_name = "/dev/sdx"
}