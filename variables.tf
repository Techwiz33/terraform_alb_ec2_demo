variable "aws_region" {
  description = "The AWS region to deploy the EC2 instance in."
  default   = "us-east-1"
}

variable "image_id" {
  description = "AMI image"
  #default   =  "ami-051f7e7f6c2f40dc1"
  default  = "ami-0419e9ce56c9a4df9"
}

variable "instance_type" {
  description = "instance type for ec2"
  default   =  "t2.micro"
}

variable "ec2_ssh_keypair" {
  default = "jenkins_ssh_keys"
}