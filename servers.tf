terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA264EKVB4RHBA32HD"
  secret_key = "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"
}

#Jenkins-Server
resource "aws_instance" "jenkins" {
  ami           = "ami-0be0a52ed3f231c12"
  instance_type = "t2.micro"
  key_name = "jenkins"
  vpc_security_group_ids = [aws_security_group.sg_grp.id]

ebs_block_device {
  device_name = "/dev/sda1"
  volume_size = 10
}

tags = {
    Name = "Jenkins Server"
  }
}

#Ansible-Server
resource "aws_instance" "ansible" {
  ami           = "ami-0be0a52ed3f231c12"
  instance_type = "t2.micro"
  key_name = "jenkins"
  vpc_security_group_ids = [aws_security_group.sg_grp.id]

ebs_block_device {
  device_name = "/dev/sda1"
  volume_size = 10
}

tags = {
    Name  = "Ansible Server"
  }

}

#WebApp-Server
resource "aws_instance" "webapp" {
  ami           = "ami-0be0a52ed3f231c12"
  instance_type = "t2.medium"
  key_name = "jenkins"
  vpc_security_group_ids = [aws_security_group.sg_grp.id]

tags = {
    Name  = "Webapp server"
  }

}

#Securtiy Group creation
resource "aws_security_group" "sg_grp" {
    name        = "sg_grp"
    description = "Allow inbound traffic"

    ingress {
        from_port     = 22
        to_port       = 22
        protocol      = "tcp"
        cidr_blocks   =["0.0.0.0/0"]
    }

    ingress {
        from_port     = 0
        to_port       = 0
        protocol      = "-1"
        cidr_blocks   =["0.0.0.0/0"]
    }

    egress {
        from_port     = 0
        to_port       = 0
        protocol      = "-1"
        cidr_blocks   =["0.0.0.0/0"]
    }

tags = {
  name = "sg_grp"
}
  
}