# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Launch EC2 Instance and Install Website
resource "aws_instance" "jenkins_ec2_instance" {
  ami                    = "ami-03a6eaae9938c858c"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-01b339f7198110906"
  vpc_security_group_ids = ["sg-0874bd3b99db42f68"]
  key_name               = "tfkp"
  user_data              = file("jenkins_install.sh")
}

# Security Group for Jenkins EC2 Instance
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Jenkins Security Group"
  vpc_id      = "vpc-0cbebd2d690f60aa5"

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


