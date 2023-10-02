# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Launch EC2 Instance and Install Website
resource "aws_instance" "jenkins_ec2_instance" {
  ami             = "ami-03a6eaae9938c858c"
  instance_type   = "t2.micro"
  security_groups = ["jenkins-sg"]
  key_name        = "tfkp"
  user_data       = file("jenkins_install.sh")
}

# Security Group for Jenkins EC2 Instance
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Jenkins Security Group"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create private s3 bucket  
resource "aws_s3_bucket" "jenkins_s3" {
  bucket = "jenkins-redteamsos-s3"
  acl    = "private"

  tags = {
    Name = "wk20tfs3"
  }
}


