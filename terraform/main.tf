
# main.tf
#################################
#           TERRAFORM           #
#################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#################################
#             REGION            #
#################################

provider "aws" {
  region     = var.region
}

#################################
#               VPC             #
#################################

resource "aws_default_vpc" "default" {
  tags = {
    Name = var.instance_name
  }
}

#################################
#            INSTANCE           #
#################################

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count         = var.create_instance ? var.instance_number : 0
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance
  key_name      = var.ssh_key
  tags = {
    Name = var.instance_name
  }
}

#################################
#        SECURTITY GROUP        #
#################################

resource "aws_security_group" "granted_ssh_marceau" {
   name        = "granted_ssh_marceau"
   description = "granted ssh marceau"

   ingress {
      description = "SSH Port"
      from_port   = var.ssh
      to_port     = var.ssh
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
      description = "Web Port"
      from_port   = var.http
      to_port     = var.http
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




#####################################

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create a EC2
resource "aws_instance" "ubuntu" {
  ami             = var.ami
  instance_type   = var.instances
  key_name        = var.ssh
  tags = {
    Name    = "instance_marceau"
    Created = "By Terraform"
  }
}

data "aws_vpc" "vpc_main" {
  id = var.id_vpc
}

ressource "aws_vpc" "vpc_ynov" {
  instance_type = var.instances
  key_name      = var.ssh
  cidr_block    = "10.0.0.0/16"

  tags = {
    Name = "vpc_marceau"
  }
}